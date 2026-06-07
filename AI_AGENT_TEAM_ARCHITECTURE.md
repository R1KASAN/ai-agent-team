---
title: AI Agent Team Architecture
version: "1.0"
last_updated: "2026-06-08"
system_type: hierarchical_multi_agent_orchestrator
---

# AI Agent Team Architecture

This system is a **hierarchical multi-agent orchestrator**. Minori is the central router and gatekeeper. Specialized agents execute scoped work through sequential handoff by default. Parallel or dynamic workflow is allowed only after Rika-Chan approval.

## 1. High-Level Orchestrator

```mermaid
flowchart TD
    U["Rika-Chan / Human Owner"] --> IG["/idea-gate"]
    IG --> MI["Minori Lead Conductor<br/>Orchestrator / Input Gatekeeper"]

    MI --> WP["workflow_plan.md<br/>job + weight + route + gates"]

    WP --> D{"Route Type"}

    D -->|recall| TS["Tsumugi<br/>Read-only Memory Recall"]
    D -->|next| IC["Ichika<br/>One Next Action"]
    D -->|scout| HI["Hikari<br/>Signal / Trend Scout"]
    D -->|memory| MR["Mira<br/>Memory Librarian"]
    D -->|research| NV["Nova-V<br/>Evidence + Verification"]
    D -->|idea / product| PIPE["Product Validation Pipeline"]
    D -->|build| AK["Aki<br/>Technical Task Architect"]

    PIPE --> YU["Yuki<br/>Idea Challenger"]
    YU --> NV
    NV --> SO["Sora<br/>Strategy Lens"]
    SO --> BU["Bumi<br/>Business Analysis"]
    BU --> PO["Poom<br/>POB / PRD / MVP Scope"]
    PO --> RG["Rika-Chan Approval Gate"]
    RG --> AK

    AK --> CTP["codex_task_packet.md<br/>test_plan.md<br/>files_likely_affected.md"]
    CTP --> CO["Coda<br/>Builder"]
    CO --> QA["Kyuuei<br/>Test + Debug"]
    QA --> TE{"Has UI?"}
    TE -->|yes| TESSA["Tessa<br/>UX Inspector"]
    TE -->|no| SHIP["Ship Gate"]
    TESSA --> SHIP
    SHIP --> RIKA2["Rika-Chan Final Approval"]
```

## 2. Sequential-By-Default Control Flow

```mermaid
flowchart LR
    A["Input"] --> B["Minori creates workflow_plan.md"]
    B --> C["Agent 1 works"]
    C --> D["Artifact 1 exists"]
    D --> E["Agent 2 works"]
    E --> F["Artifact 2 exists"]
    F --> G["Next agent / approval gate"]

    G --> H{"Approval required?"}
    H -->|yes| I["Stop for Rika-Chan"]
    H -->|no| J["Continue sequential handoff"]

    I --> K{"Approved?"}
    K -->|yes| J
    K -->|no| L["Stop / revise / archive"]

    B -.-> M["Parallel / fanout forbidden by default"]
    M -.-> N["Allowed only if six conditions + Rika-Chan approval"]
```

## 3. Gate Scope Pre-Clarification Before Aki

```mermaid
flowchart TD
    WP["workflow_plan.md"] --> SCAN["Minori scans predictable gates"]

    SCAN --> GATES["expected_gates"]

    GATES --> AUTH["auth"]
    GATES --> PAY["payment / paid API"]
    GATES --> DB["database"]
    GATES --> INFRA["infra / hosting / deploy"]
    GATES --> PRIV["privacy / security / legal"]

    GATES --> DEC["gate_decisions"]

    DEC --> PD["Pre-Decide<br/>Rika-Chan resolves before Aki"]
    DEC --> DF["Defer<br/>Named checkpoint required"]

    DF --> CCHK["Coda proposes options<br/>Rika-Chan approves before implementation / spend / deploy"]

    PD --> OK{"All gates clarified?"}
    CCHK --> OK

    OK -->|yes| AK["Aki may start"]
    OK -->|no| BLOCK["Aki must not start"]
```

## 4. Memory And Evidence Layer

```mermaid
flowchart TD
    RAW["Raw Input"] --> MIRA["Mira<br/>Tag privacy + governance metadata"]

    MIRA --> KIN["knowledge/inbox"]
    MIRA --> KREAD["knowledge/README.md index"]
    MIRA --> GRAPH["graph_update.md / Graphify"]

    KREAD --> TS["Tsumugi<br/>README-first recall"]
    GRAPH --> OBS["Obsidian backlinks / graph"]
    OBS --> TS

    TS --> JIT["Just-in-Time Context<br/>scoped, no full-vault load"]

    KREAD --> NV["Nova-V<br/>Evidence verifier"]
    NV --> WEB["Web sources"]
    NV --> NBLM["NotebookLM-py<br/>only after per-command Rika-Chan approval"]

    WEB --> VEP["verified_evidence_pack.md"]
    NBLM --> VEP

    VEP --> MIRA2["Mira writes verified research note"]
    MIRA2 --> KRES["knowledge/research"]
```

## 5. Product-To-Build Pipeline

```mermaid
flowchart TD
    IDEA["New Product Idea"] --> MI["Minori"]
    MI --> WP["workflow_plan.md"]

    WP --> YU["Yuki<br/>Challenge assumptions"]
    YU --> ICB["idea_challenge_brief.md"]

    ICB --> NV["Nova-V<br/>Verify evidence"]
    NV --> EP["verified_evidence_pack.md"]

    EP --> SO["Sora<br/>Strategy"]
    SO --> SL["strategic_lens.md"]

    SL --> BU["Bumi<br/>Business"]
    BU --> BA["business_analysis_brief.md"]

    BA --> PO["Poom<br/>Product"]
    PO --> POB["product_opportunity_brief.md"]

    POB --> G1["Rika-Chan Approval<br/>POB before PRD"]
    G1 --> PRD["prd.md + mvp_scope.md<br/>acceptance_criteria.md + out_of_scope.md"]

    PRD --> G2["Rika-Chan Approval<br/>PRD before Aki"]

    G2 --> GS["Gate Scope Pre-Clarification<br/>expected_gates + gate_decisions"]

    GS --> AK{"Gate clarified?"}
    AK -->|yes| AKI["Aki<br/>Technical translation"]
    AK -->|no| STOP["Stop before Aki"]

    AKI --> TP["technical_task_packet.md<br/>codex_task_packet.md<br/>test_plan.md"]
    TP --> CO["Coda build"]
    CO --> QA["Kyuuei test/debug"]
    QA --> SHIP["Ship check + Rika-Chan approval"]
```

## 6. Agent Team Map

```mermaid
mindmap
  root((AI Agent Team))
    Orchestrator
      Minori
        input gatekeeper
        workflow planner
        route selector
        gate scope preclarification
    Claude Team
      Yuki
        challenge assumptions
      Nova-V
        evidence search
        verification
      Sora
        strategy
        moat
      Bumi
        business viability
      Poom
        POB
        PRD
        MVP scope
      Mira
        memory write
        graph update
      Tsumugi
        recall
      Hikari
        scout
      Ichika
        next action
      Tessa
        UX inspection
      Rika-Chan
        decision gate
    Codex Team
      Aki
        technical task packet
      Coda
        implementation
      Kyuuei
        test and debug
```

## Canonical References

- `HOW_TO_USE.md` — human-facing usage guide
- `CLAUDE.md` — operating contract
- `AGENTS.md` — root agent instructions
- `workflows/workflow_index.md` — active workflow index
- `workflows/idea_gate.md` — `/idea-gate` schema and routing contract
- `templates/workflow_plan.md` — workflow plan template
