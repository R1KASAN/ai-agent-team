#!/usr/bin/env bash
set -euo pipefail

# Poll Telegram Bot API once, map allowed text commands into the local approval-first queue,
# and reply with queue/status output. This script never invokes an LLM.

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)

: "${TELEGRAM_BOT_TOKEN:?Set TELEGRAM_BOT_TOKEN before polling Telegram.}"

python3 - "$REPO_ROOT" "$TELEGRAM_BOT_TOKEN" "${TELEGRAM_ALLOWED_USER_ID:-}" <<'PY'
import json
import os
import subprocess
import sys
import urllib.parse
import urllib.request

repo_root, token, allowed_user_id = sys.argv[1], sys.argv[2], sys.argv[3]
offset_path = os.path.join(repo_root, "runtime", "telegram_gateway_offset")
queue_script = os.path.join(repo_root, "scripts", "telegram_queue.sh")


def api(method, params):
    data = urllib.parse.urlencode(params).encode("utf-8")
    url = f"https://api.telegram.org/bot{token}/{method}"
    with urllib.request.urlopen(url, data=data, timeout=20) as response:
        return json.loads(response.read().decode("utf-8"))


def send(chat_id, text):
    if len(text) > 3500:
        text = text[:3400] + "\n\n[truncated]"
    api("sendMessage", {"chat_id": chat_id, "text": text})


def run_queue(args):
    result = subprocess.run(
        ["bash", queue_script, *args],
        cwd=repo_root,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )
    return result.returncode, result.stdout.strip()


def current_offset():
    try:
        with open(offset_path, "r", encoding="utf-8") as f:
            return int(f.read().strip())
    except Exception:
        return 0


def save_offset(value):
    os.makedirs(os.path.dirname(offset_path), exist_ok=True)
    with open(offset_path, "w", encoding="utf-8") as f:
        f.write(str(value))


updates = api("getUpdates", {"offset": current_offset(), "timeout": 0}).get("result", [])
next_offset = current_offset()

for update in updates:
    next_offset = max(next_offset, int(update["update_id"]) + 1)
    message = update.get("message") or update.get("edited_message") or {}
    text = (message.get("text") or "").strip()
    chat_id = message.get("chat", {}).get("id")
    user_id = str(message.get("from", {}).get("id", ""))
    message_id = str(message.get("message_id", ""))
    if not chat_id or not text:
        continue

    if allowed_user_id and user_id != allowed_user_id:
        send(chat_id, "Unauthorized Telegram user.")
        continue

    parts = text.split()
    cmd = parts[0] if parts else ""

    if cmd in ("/idea", "/ask"):
        code, output = run_queue([
            "enqueue",
            "--user-id",
            user_id,
            "--message-id",
            message_id,
            "--text",
            text,
        ])
    elif cmd == "/status":
        code, output = run_queue(["status"])
    elif cmd == "/approve" and len(parts) == 2:
        code, output = run_queue(["approve", parts[1]])
    elif cmd == "/reject" and len(parts) == 2:
        code, output = run_queue(["reject", parts[1]])
    elif cmd == "/budget" and len(parts) == 3:
        code, output = run_queue(["budget", parts[1], parts[2]])
    else:
        code, output = 2, (
            "Supported commands:\n"
            "/idea <text>\n"
            "/ask <agent> <question>\n"
            "/status\n"
            "/approve <run_id>\n"
            "/reject <run_id>\n"
            "/budget <run_id> tiny|small|medium"
        )

    prefix = "OK" if code == 0 else "ERROR"
    send(chat_id, f"{prefix}\n{output}")

save_offset(next_offset)
print(f"processed_updates={len(updates)} next_offset={next_offset}")
PY
