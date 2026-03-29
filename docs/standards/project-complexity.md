# Project Complexity Classification

**Version:** 1.0 | **Status:** Active Standard | **ADR:** [ADR-007](../architecture/decisions/ADR-007-project-complexity-classification.md)

## Decision Flowchart

```mermaid
flowchart TD
    S["New Project"] --> U{"Users?"}
    U -->|"Personal / dev only"| C1["Tier 1 candidate"]
    U -->|"1-10 known"| C2["Tier 2 candidate"]
    U -->|"10-1000+"| C3["Tier 3 candidate"]
    U -->|"Enterprise / regulated"| C4["Tier 4 candidate"]

    C1 --> D{"Data needs?"}
    C2 --> D
    C3 --> D
    C4 --> D

    D -->|"None / flat file"| T1["Tier 1"]
    D -->|"Local SQLite / JSON"| T2["Tier 2"]
    D -->|"Server DB + auth"| T3["Tier 3"]
    D -->|"Multi-store"| T4["Tier 4"]

    T1 --> AI{"AI components?"}
    T2 --> AI
    T3 --> AI
    T4 --> AI

    AI -->|"None or single call"| F1["Final: highest tier wins"]
    AI -->|"Multi-model / agent"| UP["Escalate tier if needed"]
    UP --> F1

    style T1 fill:#27AE60,color:#fff
    style T2 fill:#2980B9,color:#fff
    style T3 fill:#D4A017,color:#000
    style T4 fill:#C0392B,color:#fff
```

!!! tip "Highest Factor Wins"
    The highest tier triggered by any single factor becomes the project tier. A project with 5 users (Tier 2) but SOC 2 compliance (Tier 3) is classified as Tier 3.

## Tier Summary

| Tier | Name | Examples | Stack |
|------|------|----------|-------|
| 1 | **Utility** | CLI tools, scripts, automations, experiments | TS/Python, no framework, JSON/flat file |
| 2 | **Application** | Mac app, internal tool, MVP, small web app | Next.js or SwiftUI, SQLite or JSON |
| 3 | **Service** | SaaS, client portal, multi-user API, AI service | Next.js + Supabase/Postgres, OpenAPI |
| 4 | **Platform** | Enterprise system, multi-service, regulated | Full stack + managed services + compliance |

## Technology Stack by Tier

```mermaid
graph LR
    subgraph Tier1["Tier 1 — Utility"]
        L1["TS / Python"] --> F1["No framework"]
        F1 --> D1["JSON / flat file"]
        D1 --> H1["Local"]
    end

    subgraph Tier2["Tier 2 — Application"]
        L2["TS / Swift"] --> F2["Next.js / SwiftUI"]
        F2 --> D2["SQLite / JSON"]
        D2 --> H2["Mac app / Vercel"]
    end

    subgraph Tier3["Tier 3 — Service"]
        L3["TS full-stack"] --> F3["Next.js + API"]
        F3 --> D3["PostgreSQL / Supabase"]
        D3 --> H3["Vercel + Supabase"]
    end

    subgraph Tier4["Tier 4 — Platform"]
        L4["TS + Swift + Python"] --> F4["Next.js + services"]
        F4 --> D4["Postgres + Redis + search"]
        D4 --> H4["Cloud + managed"]
    end

    style Tier1 fill:#27AE60,color:#fff
    style Tier2 fill:#2980B9,color:#fff
    style Tier3 fill:#D4A017,color:#000
    style Tier4 fill:#C0392B,color:#fff
```

## Execution Strategy Matrix

| Strategy | Tier 1 | Tier 2 | Tier 3 | Tier 4 |
|----------|--------|--------|--------|--------|
| **Direct coding** | Primary | Primary | Isolated tasks | Hotfixes only |
| **RALPH loop** | For single-file iteration | For feature implementation | For PRD-driven features | For bounded subsystems |
| **Spec-Driven Development** | Not needed | Optional | Recommended | Required |
| **AutoResearch** | Not applicable | Prompt/config optimization | Performance tuning | Systematic optimization |
| **NemoClaw** | N/A | N/A | Nvidia clients (eval) | Enterprise (eval) |

## Governance by Tier

| Governance | Tier 1 | Tier 2 | Tier 3 | Tier 4 |
|------------|--------|--------|--------|--------|
| Security profile | Professional | Professional | SOC 2 (if client) | Per requirement |
| Agents | Single | Single or Larry + 1-2 | Larry + specialists | Full orchestrator-worker |
| Code review | Self | Self or 1 reviewer | PR + 1 approval | PR + 2 approvals |
| Testing | Manual | 80% unit coverage | Unit + integration + E2E | Full suite + security |
| RSP gates | None | Threat model (if AI) | Full lifecycle | Full + audit trail |

## Data Layer Decision

| Scenario | Choice | Rationale |
|----------|--------|-----------|
| No persistence | In-memory / flat file | Zero overhead |
| Local Mac, single user | SQLite | Apple-native, zero-config |
| Simple web, <100 records | JSON objects | No DB overhead |
| Web app + auth + multi-user | PostgreSQL via Supabase | Managed, scalable, auth included |
| Enterprise + caching | PostgreSQL + Redis | Persistence + performance |

## Tier Escalation

Projects escalate when any factor crosses the tier boundary. When escalating: update project CLAUDE.md, apply new tier defaults, document the trigger.

For the full operational standard, see `framework/standards/project-complexity.md`. For decision rationale, see [ADR-007](../architecture/decisions/ADR-007-project-complexity-classification.md).
