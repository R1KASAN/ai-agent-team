export const meta = {
  name: 'idea-stresstest',
  description: 'Adversarial idea validation + cross-checked evidence → merged opportunity brief. Heavy/strategic only, after Rika dynamic approval.',
  whenToUse: 'Run ONLY when /idea-gate classified weight=heavy|strategic AND Rika-Chan approved context_budget: dynamic. Not a default path.',
  phases: [
    { title: 'Challenge', detail: '3 independent Yuki voices surface riskiest assumptions' },
    { title: 'Evidence', detail: 'Nova-V verifies each assumption (notebooklm-py gated)' },
    { title: 'Lens', detail: 'Sora strategy + Bumi viability, independent' },
    { title: 'Merge', detail: 'reconcile into one opportunity brief draft' },
  ],
}

// ---------------------------------------------------------------------------
// idea-stresstest — the ONE real JS Dynamic Workflow proof for Studio OS v2.
//
// Governance (must hold — see context.md, llm_wiki/dynamic_workflow_policy.md):
//   * This script is the heavy/strategic execution_mode ONLY. Minori recommends it and STOPS;
//     a human launches it after Rika-Chan approves context_budget: dynamic.
//   * notebooklm-py is Nova-V-only and requires per-command approval EVERY time. The evidence
//     stage must ask for approval before any notebooklm-py call; if not granted, fall back to
//     web/knowledge evidence and label confidence accordingly. Never pass client PII/secrets.
//   * Token economy: this is a pipeline (no barrier between stages) so a fast assumption is
//     verified while a slow one is still being challenged. Intermediate results stay in script
//     variables — only the final merged brief returns to the main context.
//   * Output is a DRAFT brief. It still passes the normal Rika-Chan POB approval gate before any
//     PRD/build. This workflow does not ship anything.
//
// args (passed by the launcher):
//   { idea: string, artifacts?: string[], weight?: 'heavy'|'strategic', notebooklm_approved?: boolean }
// ---------------------------------------------------------------------------

const idea = (args && args.idea) || (typeof args === 'string' ? args : '')
const artifacts = (args && args.artifacts) || []
const weight = (args && args.weight) || 'heavy'
const nlmApproved = !!(args && args.notebooklm_approved)
const rikaApproved = !!(args && args.rika_dynamic_approved)

// --- HARD GUARD (Flag A): no Rika dynamic approval → abort before ANY work. ----------------
// This is a runtime precondition, not prose. Without it, no fan-out agent starts, no
// notebooklm-py call is reachable, and no opportunity brief is produced.
if (!rikaApproved) {
  log('ABORT: context_budget:dynamic not approved by Rika-Chan. /idea-gate must gate this first.')
  return {
    error: 'dynamic_not_approved',
    fanout_started: false,
    notebooklm_used: false,
    opportunity_brief: null,
    next_gate: 'Rika-Chan dynamic-budget approval required (pass args.rika_dynamic_approved = true).',
  }
}

if (!idea) {
  log('No idea provided in args.idea — aborting. Pass { idea: "..." }.')
  return { error: 'missing_idea' }
}

const artifactNote = artifacts.length
  ? `Reference these artifacts by path (do not paste full content): ${artifacts.join(', ')}.`
  : 'No prior artifacts supplied; rely on the idea statement plus your own scoped research.'

// --- Schemas (force structured returns; no parsing needed) -----------------
const ASSUMPTIONS_SCHEMA = {
  type: 'object',
  properties: {
    voice: { type: 'string' },
    assumptions: {
      type: 'array',
      items: {
        type: 'object',
        properties: {
          claim: { type: 'string' },
          why_risky: { type: 'string' },
          kills_idea_if_false: { type: 'boolean' },
        },
        required: ['claim', 'why_risky', 'kills_idea_if_false'],
      },
    },
  },
  required: ['voice', 'assumptions'],
}

const EVIDENCE_SCHEMA = {
  type: 'object',
  properties: {
    claim: { type: 'string' },
    label: { type: 'string', enum: ['FACT', 'ASSUMPTION', 'UNSUPPORTED', 'CONTRADICTION', 'HALLUCINATION_RISK'] },
    confidence: { type: 'number' },
    source_tier: { type: 'integer' },
    notebooklm_used: { type: 'boolean' },
    note: { type: 'string' },
  },
  required: ['claim', 'label', 'confidence', 'notebooklm_used'],
}

const LENS_SCHEMA = {
  type: 'object',
  properties: {
    lens: { type: 'string' },
    verdict: { type: 'string' },
    rationale: { type: 'string' },
    moat_or_wtp: { type: 'string' },
  },
  required: ['lens', 'verdict', 'rationale'],
}

const MERGE_SCHEMA = {
  type: 'object',
  properties: {
    recommendation: { type: 'string', enum: ['proceed', 'reframe', 'kill', 'needs_owner_decision'] },
    conflict_level: { type: 'string', enum: ['low', 'medium', 'high'] },
    top_risks: { type: 'array', items: { type: 'string' } },
    opportunity_brief_draft: { type: 'string' },
    open_questions_for_owner: { type: 'array', items: { type: 'string' } },
  },
  required: ['recommendation', 'conflict_level', 'opportunity_brief_draft'],
}

// --- Phase 1: Challenge — three independent Yuki voices --------------------
phase('Challenge')
const VOICES = [
  { key: 'tech', q: 'Can this realistically be built and shipped by a solo founder in ~30 days? What technical assumption is riskiest?' },
  { key: 'market', q: 'Will anyone actually pay for this, and enough? What demand/WTP assumption is riskiest?' },
  { key: 'risk', q: 'What single assumption, if false, is fatal (legal/privacy/strategic/dependency)?' },
]

const challenge = await parallel(
  VOICES.map((v) => () =>
    agent(
      `You are Yuki (idea challenger), the "${v.key}" voice. Idea: "${idea}". ${artifactNote}\n` +
        `${v.q}\nReturn 1-3 riskiest assumptions, Socratic and specific. Do not validate the idea.`,
      { label: `challenge:${v.key}`, phase: 'Challenge', schema: ASSUMPTIONS_SCHEMA }
    )
  )
).then((rs) => rs.filter(Boolean))

// dedupe assumptions across voices (plain code — needs all voices, so the barrier above is correct)
const seen = new Set()
const assumptions = []
for (const r of challenge) {
  for (const a of r.assumptions || []) {
    const k = a.claim.trim().toLowerCase().slice(0, 80)
    if (!seen.has(k)) {
      seen.add(k)
      assumptions.push({ ...a, voice: r.voice })
    }
  }
}
log(`Challenge: ${assumptions.length} distinct assumptions from ${challenge.length} voices.`)

// --- Phase 2: Evidence — verify each assumption (pipeline, no barrier) -----
phase('Evidence')
const nlmRule = nlmApproved
  ? 'notebooklm-py IS approved for this run (Nova-V only, this command only). You MAY use it for deep source reads of public / Rika-owned non-sensitive sources ONLY. Never client PII/secrets/paywalled. Set notebooklm_used: true only when you actually used it.'
  : 'notebooklm-py is NOT approved for this run. You MUST NOT call it under any circumstance. You MUST set notebooklm_used: false and proceed with web + knowledge/ evidence ONLY, lowering confidence accordingly. Calling notebooklm-py without approval is a GOVERNANCE VIOLATION — do not do it. notebooklm-py is Nova-V-only and per-command approval-gated.'

const evidence = await pipeline(
  assumptions,
  (a) =>
    agent(
      `You are Nova-V (evidence + verify). Verify this assumption for idea "${idea}":\n` +
        `"${a.claim}" (why risky: ${a.why_risky}).\n` +
        `Check knowledge/README.md index first, then discover sources. ${nlmRule}\n` +
        `Label by entailment, give confidence 0-1 and source_tier (1=primary). Set notebooklm_used honestly.`,
      { label: `evidence:${a.claim.slice(0, 32)}`, phase: 'Evidence', schema: EVIDENCE_SCHEMA }
    )
).then((rs) => rs.filter(Boolean))
log(`Evidence: verified ${evidence.length} assumptions.`)

// --- Phase 3: Lens — Sora + Bumi independent ------------------------------
phase('Lens')
const evidenceDigest = evidence
  .map((e) => `- [${e.label} ${Math.round((e.confidence || 0) * 100)}%] ${e.claim}`)
  .join('\n')

const lenses = await parallel([
  () =>
    agent(
      `You are Sora (strategist). Idea: "${idea}". Verified evidence:\n${evidenceDigest}\n` +
        `Apply old-game/new-game + moat + 3-5yr bet. Verdict: proceed | reframe | kill. Flag DVD-trap.`,
      { label: 'lens:strategy', phase: 'Lens', schema: LENS_SCHEMA }
    ),
  () =>
    agent(
      `You are Bumi (business analyst). Idea: "${idea}". Verified evidence:\n${evidenceDigest}\n` +
        `Assess target user, pain severity, WTP signal, revenue path. Verdict: viable | needs_reframe | not_viable.`,
      { label: 'lens:business', phase: 'Lens', schema: LENS_SCHEMA }
    ),
]).then((rs) => rs.filter(Boolean))

// --- Phase 4: Merge — reconcile into one draft brief ----------------------
phase('Merge')
const fatal = assumptions.filter((a) => a.kills_idea_if_false)
const merged = await agent(
  `You are Poom (product manager) writing for an owner with 30 seconds. Reconcile into ONE decision.\n` +
    `Idea: "${idea}".\n` +
    `Fatal-if-false assumptions: ${fatal.map((a) => a.claim).join('; ') || 'none flagged'}.\n` +
    `Evidence:\n${evidenceDigest}\n` +
    `Strategy + business lenses:\n${lenses.map((l) => `- ${l.lens}: ${l.verdict} — ${l.rationale}`).join('\n')}\n` +
    `Produce a product_opportunity_brief DRAFT, recommendation, conflict_level, top_risks, and ` +
    `open_questions_for_owner. This is a DRAFT — it still needs Rika-Chan POB approval before any build.`,
  { label: 'merge:brief', phase: 'Merge', schema: MERGE_SCHEMA }
)

log(`Done. Recommendation=${merged.recommendation} conflict=${merged.conflict_level}. Brief is a DRAFT — Rika-Chan POB gate still applies.`)

return {
  idea,
  weight,
  notebooklm_approved: nlmApproved,
  assumptions,
  evidence,
  lenses,
  merged,
  next_gate: 'Rika-Chan must approve product_opportunity_brief before PRD/build.',
}
