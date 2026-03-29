# Project Complexity Classification Standard

**Version:** 1.0
**Date:** March 29, 2026
**Status:** Active Standard
**ADR:** ADR-007

## Purpose

Every project begins with a tier classification. The tier determines technology stack, execution strategy, data layer, deployment target, and governance level. This eliminates ad hoc decision-making and ensures appropriate rigor is applied to every engagement.

## Decision Process

### Step 1: Classify the Project

Answer these questions. The highest tier triggered by any single factor becomes the project tier.

**Users and Scale**
- Personal use or developer-only → Tier 1
- 1-10 known users → Tier 2
- 10-1000+ users or public-facing → Tier 3
- Enterprise client, 1000+ users, or regulated industry → Tier 4

**Data Requirements**
- No persistence or flat files → Tier 1
- Local persistence (JSON, SQLite) → Tier 2
- Server-side database with auth → Tier 3
- Multi-store (database + cache + search) → Tier 4

**AI Components**
- None or single API call → Tier 1
- Single model integration → Tier 2
- Multi-model or single agent → Tier 3
- Multi-agent system with governance → Tier 4

**Compliance**
- No requirements → Tier 1 or 2
- Client expects professional standards → Tier 2
- SOC 2, HIPAA, or contractual security obligations → Tier 3
- Zero-trust, government, regulated, or audit-required → Tier 4

**Lifespan**
- Days to weeks (prototype, experiment) → Tier 1
- Months (internal tool, MVP) → Tier 2
- 1-3 years (product, client engagement) → Tier 3
- 3+ years or ongoing (platform, enterprise) → Tier 4

### Step 2: Apply the Tier Defaults

Once classified, the project inherits defaults from the tables below. Deviations are permitted but must be documented in the project's CLAUDE.md with rationale.

## Tier Definitions

### Tier 1 — Utility

Scripts, automations, CLI tools, quick prototypes, experiments.

| Component | Default |
|-----------|---------|
| Language | TypeScript or Python (whichever is faster) |
| Framework | None or minimal |
| Data | JSON files or in-memory |
| Hosting | Local filesystem |
| Security profile | Professional Standard |
| Agent architecture | Single agent (no orchestrator) |
| Execution strategy | Direct coding |
| Testing | Manual verification |
| Documentation | README only |
| RSP gates | None |

### Tier 2 — Application

Single-user or small-team apps with persistent data, deployed to one platform.

| Component | Default |
|-----------|---------|
| Language | TypeScript or Swift |
| Framework | Next.js (web) or SwiftUI (Mac/iOS) |
| Data | SQLite (Mac deployment) or JSON (simple web) |
| Hosting | Local Mac app or single Vercel deployment |
| Security profile | Professional Standard |
| Agent architecture | Single agent or Larry + 1-2 specialists |
| Execution strategy | Direct coding; RALPH loop for feature iteration |
| Testing | Unit tests, 80% coverage |
| Documentation | README + inline docs |
| RSP gates | Threat model if AI features present |

### Tier 3 — Service

Multi-user applications with APIs, authentication, cloud deployment.

| Component | Default |
|-----------|---------|
| Language | TypeScript (full-stack) or Swift + API |
| Framework | Next.js + API routes, or Vapor (Swift) |
| Data | PostgreSQL / Supabase |
| Hosting | Vercel + Supabase (or equivalent) |
| Security profile | Enterprise SOC 2 (if client engagement) |
| Agent architecture | Larry + specialists |
| Execution strategy | Spec-Driven Development recommended; RALPH for bounded features; AutoResearch for performance tuning |
| Testing | Unit + integration + E2E |
| Documentation | Full docs + OpenAPI spec |
| RSP gates | Full RSP lifecycle |

### Tier 4 — Platform

Multi-service systems with AI agents, compliance requirements, enterprise clients.

| Component | Default |
|-----------|---------|
| Language | TypeScript + Swift + Python as needed |
| Framework | Next.js + separate API services |
| Data | PostgreSQL + Redis + search index |
| Hosting | Cloud provider + managed services |
| Security profile | Per client requirement (SOC 2, Maximum, or custom) |
| Agent architecture | Full orchestrator-worker (Larry + all specialists) |
| Execution strategy | Spec-Driven Development required; RALPH for subsystem implementation; AutoResearch for systematic optimization; NemoClaw evaluation for Nvidia-ecosystem clients |
| Testing | Full test suite + security tests + penetration testing |
| Documentation | Full docs + OpenAPI + ADRs + compliance documentation |
| RSP gates | Full RSP + audit trail + quarterly review |

## Execution Strategy Selection

Independent of tier, choose the execution strategy based on the task characteristics:

| Strategy | When to Use | Requirements |
|----------|-------------|-------------|
| **Direct coding** | Isolated tasks, hotfixes, well-understood changes | Clear requirements, bounded scope |
| **RALPH loop** | Feature implementation from a PRD, iterative refinement | Written PRD or spec, measurable "done" criteria |
| **Spec-Driven Development** | Multi-feature builds, team coordination, enterprise projects | Detailed specification document, test assertions |
| **AutoResearch** | Measurable optimization (performance, prompts, queries, builds) | Measurable metric, controllable variable, repeatable evaluation |
| **NemoClaw** | Runtime isolation for AI agents in Nvidia-ecosystem deployments | Nvidia GPU infrastructure, enterprise governance requirement |

## Data Layer Decision

| Scenario | Data Layer | Rationale |
|----------|-----------|-----------|
| No persistence needed | In-memory / flat file | Simplest option; no setup overhead |
| Local Mac app, single user | SQLite | Apple-native, zero-config, file-based, fast |
| Simple web app, <100 records | JSON objects | No database overhead; version-controllable |
| Web app with auth, multi-user | PostgreSQL via Supabase | Managed, scalable, auth included, real-time subscriptions |
| Enterprise with caching needs | PostgreSQL + Redis | PostgreSQL for persistence, Redis for session/cache |
| Full-text search required | PostgreSQL + search index | pg_trgm for basic; dedicated search service for advanced |

## Tier Escalation Triggers

Projects may need to move up a tier when:

- User count exceeds tier boundary
- Client adds compliance requirements
- AI components are added or expanded
- Multiple deployment targets are needed
- Data requirements grow beyond tier capacity

When escalating: update the project CLAUDE.md with the new tier, apply the new tier's defaults, and document the trigger in a brief ADR or decision log entry.

## Client Advisory Application

When advising C-Suite clients, use the classification criteria to recommend the appropriate tier for their project. This provides a defensible, structured recommendation rather than ad hoc technology opinions. The tier maps directly to budget expectations, timeline ranges, and governance requirements.
