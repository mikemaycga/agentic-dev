# ADR-007: Project Complexity Classification

**Status:** Accepted
**Date:** 2026-03-29

## Context

The framework supports projects ranging from single-file utilities to enterprise multi-service applications. Without a decision framework, every project risks over-engineering (full orchestrator-worker pipeline for a 200-line script) or under-engineering (no governance on a production AI agent). The framework also now includes multiple execution strategies (direct coding, RALPH loop, Spec-Driven Development, AutoResearch) and deployment targets (local Mac, cloud, hybrid) that must be matched to project characteristics.

Industry practice (PMI complexity classification, decision matrices) recommends 4-8 evaluation criteria producing 3-5 tiers. Our framework needs to map complexity tiers to specific technology stacks, execution strategies, governance levels, and deployment patterns.

## Decision

Adopt a four-tier project complexity classification that determines the technology stack, development methodology, data strategy, deployment target, and governance level for every project.

### Tiers

| Tier | Name | Description |
|------|------|-------------|
| 1 | **Utility** | Single-purpose scripts, automations, CLI tools, quick prototypes |
| 2 | **Application** | Single-user or small-team apps with persistent data, deployed to one platform |
| 3 | **Service** | Multi-user applications with APIs, authentication, cloud deployment |
| 4 | **Platform** | Multi-service systems with AI agents, compliance requirements, enterprise clients |

### Classification Criteria (4-8 factors)

| Factor | Tier 1 | Tier 2 | Tier 3 | Tier 4 |
|--------|--------|--------|--------|--------|
| **Users** | 1 (developer) | 1-10 | 10-1000+ | 1000+ or enterprise |
| **Data persistence** | None or flat file | JSON/SQLite | PostgreSQL/Supabase | PostgreSQL + caching + search |
| **Deployment target** | Local Mac only | Single Mac app or single cloud service | Cloud (Vercel/similar) + database | Multi-service cloud + CDN + monitoring |
| **Authentication** | None | Apple Keychain / local | OAuth 2.0 / Supabase Auth | SSO / RBAC / MFA |
| **AI components** | None or single prompt | Single model integration | Multi-model or agent-based | Multi-agent with governance (Larry + specialists) |
| **Compliance requirements** | None | Professional Standard profile | Enterprise SOC 2 profile | Maximum (Zero Trust) profile |
| **Team size** | Solo | Solo or pair | 2-5 | 5+ or cross-functional |
| **Expected lifespan** | Days to weeks | Months | 1-3 years | 3+ years or ongoing |

### Technology Stack by Tier

| Component | Tier 1 | Tier 2 | Tier 3 | Tier 4 |
|-----------|--------|--------|--------|--------|
| **Language** | TypeScript/Python (whichever is faster for the task) | TypeScript or Swift | TypeScript (full-stack) or Swift + API | TypeScript + Swift + Python as needed |
| **Framework** | None (vanilla) or minimal | Next.js or SwiftUI | Next.js + API routes or Vapor | Next.js + separate API + microservices |
| **Data** | JSON files or in-memory | SQLite (Mac) or JSON (web) | PostgreSQL / Supabase | PostgreSQL + Redis + search index |
| **Frontend** | HTML/CSS or terminal | React/SwiftUI | React + Tailwind | React + design system |
| **API** | None | Internal only | REST or GraphQL (OpenAPI documented) | REST + GraphQL + WebSocket (OpenAPI required) |
| **Hosting** | Local filesystem | Local Mac app or single Vercel deploy | Vercel + Supabase | Cloud provider + managed services |

### Execution Strategy by Tier

| Strategy | Tier 1 | Tier 2 | Tier 3 | Tier 4 |
|----------|--------|--------|--------|--------|
| **Direct coding** (human + single agent) | Primary | Primary for simple features | For isolated tasks | For hotfixes only |
| **RALPH loop** (persistent-progress loop) | For iteration on single files | For feature implementation | For PRD-driven feature sets | For bounded subsystems |
| **Spec-Driven Development** | Not needed | Optional | Recommended | Required |
| **AutoResearch** | Not applicable | For prompt/config optimization | For performance tuning | For systematic optimization |
| **NemoClaw** | Not applicable | Not applicable | Evaluation candidate (Nvidia clients) | Evaluation candidate (enterprise) |

### Governance by Tier

| Governance | Tier 1 | Tier 2 | Tier 3 | Tier 4 |
|------------|--------|--------|--------|--------|
| **Security profile** | Professional Standard | Professional Standard | Enterprise SOC 2 (if client) | Per client requirement |
| **Agent architecture** | Single agent | Single agent or Larry + 1-2 specialists | Larry + specialists | Full orchestrator-worker |
| **Code review** | Self-review | Self-review or single reviewer | PR required, 1 approval | PR required, 2 approvals |
| **Testing** | Manual verification | Unit tests (80% coverage) | Unit + integration + E2E | Full test suite + security tests |
| **Documentation** | README only | README + inline docs | Full docs + API docs | Full docs + API docs + ADRs |
| **RSP gates** | None | Threat model if AI features | Full RSP lifecycle | Full RSP + audit trail |

## Consequences

- Every new project begins with a tier classification decision before any code is written
- The tier determines default technology choices, reducing decision fatigue
- Tiers can escalate (Tier 2 → 3) as requirements grow; the classification includes upgrade triggers
- The standard document provides the operational decision tree; this ADR captures the rationale
- Client advisory engagements use this framework to recommend appropriate complexity levels

## Alternatives Considered

- **Three tiers (small/medium/large):** Rejected. Too coarse — a single Mac app and a CLI script have very different needs but both land in "small."
- **Five+ tiers:** Rejected. Over-classification creates decision paralysis. Four tiers map cleanly to the framework's security profiles and deployment patterns.
- **No formal classification:** Rejected. Without it, every project defaults to either over- or under-engineering. The framework already has different governance levels; this formalizes when each applies.
- **Per-project ad hoc decisions:** Rejected. Inconsistency across projects, no reusable patterns, higher cognitive load per decision.

## Sources

- PMI Project Complexity Classification (pmi.org/learning/library/project-complexity-determine-rigor-9874)
- Spec-Driven Development mapping (medium.com/@visrow)
- Framework security profiles (Professional Standard, Enterprise SOC 2, Maximum)
- RALPH/AutoResearch assessments (knowledge-library/assessments/)
