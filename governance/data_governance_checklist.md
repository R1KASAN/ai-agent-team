---
version: "1.0"
maintained_by: Gina Governance Guardian
authority: Rika-Chan
---

# Data Governance Checklist

Apply this checklist to every source, memory item, evidence pack, product decision, and build artifact that involves external data or user data.

---

## 1. Source Metadata (apply per source)

- [ ] `source_url_or_path` recorded in `logs/source_log.md`
- [ ] `source_type` identified (article / paper / dataset / interview / screenshot / note / official_doc)
- [ ] `captured_at` timestamp recorded
- [ ] `owner` identified (author / organisation / unknown)
- [ ] `topic` and `entities` tagged
- [ ] `confidence` assessed (high / medium / low)
- [ ] `privacy_level` assigned (public / internal / sensitive / restricted)
- [ ] `usage_decision` set (approved / pending / restricted / excluded)
- [ ] `last_verified_at` recorded if source is time-sensitive
- [ ] `related_project` linked

**Fail condition:** No source + no timestamp + low confidence → not valid as primary evidence. Stop.

---

## 2. Privacy Assessment (apply per artifact containing user or client data)

- [ ] PII present? If yes → flag `privacy_level: restricted`; route to Gina before proceeding
- [ ] Client data present? If yes → flag `privacy_level: sensitive`
- [ ] Data minimisation applied? (only the minimum data needed is used)
- [ ] Data subject notified or consent established if applicable
- [ ] Data retention period defined if applicable

**Fail condition:** PII present and not flagged → hard stop; escalate to Rika-Chan.

---

## 3. Data Ownership

- [ ] Data owner identified where possible
- [ ] Usage rights confirmed (licence, ToS, permission)
- [ ] Scraping against ToS confirmed absent
- [ ] Third-party data import approved if batch > 10 sources

---

## 4. Source Quality

- [ ] Source type known (not anonymous or unknown-origin)
- [ ] Recency acceptable for the decision being made
- [ ] Author or organisation credibility assessed
- [ ] Conflicts of interest noted if known
- [ ] Methodology visible for research or data sources

---

## 5. High-Risk Domain Rules

For finance, legal, privacy, security, health, or production infrastructure:

- [ ] Domain-specific trusted sources used (not generic web search)
- [ ] Confidence level explicitly stated
- [ ] Source conflict flagged if present
- [ ] Escalated to Rika-Chan if confidence is low or sources conflict

---

## 6. Approval Triggers

Gina must produce `approval_request.md` and halt if any of the following are true:

- [ ] PII or restricted data found in artifact
- [ ] Source quality fails minimum criteria
- [ ] Legal concern flagged
- [ ] Security-sensitive data path identified
- [ ] Data ownership is unclear for a critical source
- [ ] High-risk domain with conflicting or low-confidence sources

---

> Log updates: `logs/risk_log.md` · `logs/source_log.md`
> Authority: `governance/approval_gates.md`
