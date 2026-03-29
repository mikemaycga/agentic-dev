# Framework Backlog

**Last Updated:** 2026-03-29
**Status:** Active

## High Priority

| # | Item | Deliverable | Dependencies | Status |
|---|------|-------------|--------------|--------|
| 1 | Project Complexity Criteria | Framework standard + decision tree: when to use simple HTML/Node vs full environment vs Java vs RALPH vs AutoResearch vs NemoClaw | None (prerequisite for others) | Backlog |
| 2 | Deterministic Machine Builds | Provisioning script (Brewfile + config automation) for identical Macs. Includes "Deploy Dev Environment to Another Mac" | Item 1 informs what gets installed | Backlog |
| 3 | Database Strategy by Deployment | ADR-007: JSON (small) → SQLite (local Mac) → Postgres/Supabase (cloud) with decision criteria | Item 1 | Backlog |
| 4 | Swift App Deployment Patterns | Project templates + ADR: single Mac app, Apple sync, cloud-connected Swift | Items 2, 3 | Backlog |
| 5 | Upgrade Existing Projects | Migration checklist + script to bring pre-framework projects under governance | Items 1, 2 | Backlog |

## Medium Priority

| # | Item | Deliverable | Dependencies | Status |
|---|------|-------------|--------------|--------|
| 6 | Cloud Infrastructure Strategy | ADR: Vercel vs alternatives, Supabase vs standalone Postgres, single instance vs split | Item 3 | Backlog |
| 7 | API Documentation Standards | Standard for OpenAPI spec + tooling selection (Swagger/Redoc/Stoplight) | Item 6 | Backlog |
| 8 | RALPH Loop + SDD Integration | ADR: when/how to use RALPH and Spec-Driven Development alongside orchestrator-worker | Item 1 | Backlog |
| 9 | AutoResearch Pattern Integration | Framework tool in `framework/tools/autoresearch/` with program.md template. For measurable optimization problems (prompts, performance, queries, builds) | Item 1 | Backlog |
| 10 | Environment Maintenance | Scheduled update checks, notification workflow, fix process across machines | Item 2 | Backlog |

## Deferred / Scheduled Research

| Item | Tracking | Trigger |
|------|----------|---------|
| NemoClaw Build/Runtime Integration | Q14 in architecture doc | Nvidia-ecosystem client engagement |
| Governance Platform Evaluation (Credo AI, AgentID) | Q15 in architecture doc | Layer 3 implementation need |
| Larry Orchestrator Maturity | Q13 in architecture doc | Post-pilot assessment |
| Plugin Research | Q3/Q6 in architecture doc | Scheduled future task |

## Completed (This Session)

| Item | Deliverable |
|------|-------------|
| MkDocs Documentation Site | 28 pages, live at https://mikemaycga.github.io/agentic-dev/ |
| RSP v3.0 Integration | ADR-005, lifecycle touchpoints, agent updates |
| Three-Layer Safe AI Governance | ADR-006, SOC 2 + ISO 27001 mapping |
| NemoClaw Assessment | Knowledge library assessment, archived research |
| AutoResearch Assessment | Knowledge library assessment |
| Cross-Machine Setup | setup.sh, SETUP-INSTRUCTIONS.md |
| GitHub Repository | Public, pushed to github.com/mikemaycga/agentic-dev |
