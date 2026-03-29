# ADR-006: Safe AI Governance — Three-Layer Model

**Status:** Accepted
**Date:** 2026-03-29

## Context

Enterprise AI agents that take real actions (code execution, API calls, database writes, file system access) require more than policy-level governance. The NemoClaw/Anthropic runtime isolation landscape analysis (March 2026) identified a critical gap: Anthropic provides governance-level controls (RSP, RBAC, logging) but no customer-facing runtime isolation. Our framework had policy gates (Sentinel, RSP-informed security baseline) but no infrastructure-level enforcement. For enterprise clients subject to SOC 2 and ISO 27001, auditors require demonstrable isolation, not just policy documentation.

## Decision

Adopt a three-layer safe AI governance model that addresses governance, infrastructure, and audit separately:

**Layer 1 — Anthropic-Native Governance (Operational)**
Claude Enterprise controls (RBAC, data isolation, usage logging), RSP v3.0 integration (ADR-005), Sentinel security gates, threat model and risk-benefit assessment requirements. This layer is operational in our framework today.

**Layer 2 — Own Infrastructure Isolation (To Be Implemented)**
Container-based agent isolation (Docker/Kubernetes), deny-by-default network policies with explicit egress allowlists, filesystem restrictions per agent, centralized logging forwarded to SIEM as the system of record. Pattern derived from NemoClaw architecture (adopted as pattern, not product). This layer requires implementation when projects move to production agent deployments.

**Layer 3 — Governance Platform & Audit (Evaluation Scheduled)**
Vendor-neutral governance overlay for agent registry, policy enforcement, and audit-grade evidence. Candidates: Credo AI, AgentID, or equivalent. Plus NemoClaw evaluation for Nvidia-ecosystem clients. Compliance mapping to SOC 2 + ISO 27001. This layer requires dedicated evaluation research.

## Compliance Target

SOC 2 Type II + ISO 27001, mapped to four auditor requirements:

| Auditor Requirement | Layer 1 | Layer 2 | Layer 3 |
|---|---|---|---|
| Evidence-quality audit trails | Claude Enterprise logs | SIEM ingestion | Governance platform |
| Control mapping (SOC 2/ISO) | RSP gates, security profiles | Network/filesystem policies | Registry + policy packs |
| Demonstrable isolation | Data isolation (Claude Enterprise) | Container/namespace isolation | Agent boundary documentation |
| Kill switches | API key revocation, Sentinel block | Container termination | Agent registry status |

## Scope

This approach serves two purposes:
1. **Framework** — How we build and deploy AI-powered systems
2. **Client Advisory** — Reusable governance model for enterprise C-Suite engagements

## Consequences

- Layer 1 is already integrated (ADR-005). No additional work required.
- Layer 2 requires implementation standards when projects move to production. Documented in `safe-ai-governance.md`.
- Layer 3 requires dedicated research (governance platform evaluation, NemoClaw evaluation). Scheduled as future tasks.
- Client advisory template to be created in `cowork-projects/` for enterprise engagements.
- All agent definitions maintain the "design for exit" principle — business logic stays framework-neutral, security policies are separated from business logic, observability is centralized outside any single vendor.

## Alternatives Considered

- **NemoClaw as primary runtime:** Rejected for our framework. Alpha-stage, GPU-oriented, Nvidia lock-in. Retained as evaluation candidate for Nvidia-ecosystem clients.
- **Microsoft Azure stack:** Rejected as primary. Azure-locked. Retained as client advisory option for Microsoft-standardized enterprises.
- **Policy-only governance (no infrastructure layer):** Rejected. Policy gates tell agents what they should not do; infrastructure isolation prevents them from doing it. Auditors require both.
- **Full compliance stack (SOC 2 + ISO + NIST AI RMF + EU AI Act):** Deferred. SOC 2 + ISO 27001 covers the majority of current client requirements. NIST AI RMF and EU AI Act can be added per engagement.

## Sources

- NemoClaw/Anthropic landscape assessment: `knowledge-library/assessments/2026-03-29-nemoclaw-runtime-isolation-landscape.md`
- Anthropic RSP v3.0: `knowledge-library/assessments/2026-03-29-anthropic-rsp-v3-framework-implications.md`
