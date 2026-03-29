# Safe AI Governance Standard

**Version:** 1.0
**Date:** March 29, 2026
**Status:** Active Standard
**ADR Reference:** ADR-006-safe-ai-governance
**Compliance Target:** SOC 2 Type II + ISO 27001

---

## Governing Principle

AI agents that take real-world actions require governance at three levels: model-level controls (what the AI is allowed to do), infrastructure-level isolation (what the AI is physically capable of doing), and audit-level evidence (proof that controls are working). Policy without enforcement is documentation. Enforcement without audit is trust. Enterprise clients require all three.

---

## 1. Three-Layer Architecture

### Layer 1 — Anthropic-Native Governance (Operational)

Controls provided by Anthropic's platform and enforced by our framework:

| Control | Source | Enforced By |
|---------|--------|-------------|
| AI Safety Level safeguards (ASL-3) | Anthropic RSP v3.0 | Anthropic (inherited) |
| Data isolation (customer data not used for training) | Claude Enterprise | Anthropic |
| RBAC and access policies | Claude Enterprise | Admin configuration |
| Usage logging | Claude Enterprise | Anthropic + SIEM forwarding |
| Threat model documentation | Framework (ADR-005) | Architect + Sentinel |
| Risk-benefit assessment | Framework (ADR-005) | Sentinel (blocking gate) |
| Agent auditability | Framework (ADR-005) | Larry + Deployer |
| Safety classifier handling | Framework code rules | Specialist agents |

**Status:** Operational. Integrated into framework via ADR-005 and security-baseline.md v1.1.

### Layer 2 — Infrastructure Isolation (Implementation Standard)

Controls enforced by infrastructure, independent of model behavior:

| Control | Pattern | Implementation |
|---------|---------|----------------|
| Agent process isolation | One container per agent or agent group | Docker / Kubernetes pods |
| Network deny-by-default | No outbound access unless explicitly allowed | Kubernetes NetworkPolicy / Docker network rules |
| Egress allowlisting | Each agent declares which external services it may contact | YAML policy per agent (inspired by NemoClaw pattern) |
| Filesystem restrictions | Agents access only their designated directories | Volume mounts with read-only where possible |
| Resource limits | CPU/memory caps per agent | Kubernetes resource quotas |
| Privacy routing | Sensitive data processed locally or via Claude Enterprise; non-sensitive may use other endpoints | API gateway / routing layer |
| Kill switch | Ability to terminate any agent instantly | Container lifecycle management + API key revocation |

**Implementation guidance:**

When deploying AI agents to production, each agent or agent group must run in an isolated container with explicit network and filesystem policies. The pattern is deny-by-default: the agent cannot reach any network endpoint or filesystem path unless the deployment configuration explicitly allows it.

Example egress policy (conceptual YAML — adapt to your container orchestrator):
```yaml
agent: architecture-review
network:
  egress:
    allow:
      - api.anthropic.com:443
      - github.com:443
    deny: all
filesystem:
  read:
    - /app/project/
    - /app/framework/standards/
  write:
    - /app/output/
  deny: all
resources:
  cpu: "1"
  memory: "2Gi"
```

**Status:** Standard defined. Implementation required when projects deploy AI agents to production environments.

### Layer 3 — Governance Platform & Audit (Evaluation Pending)

Controls for centralized agent registry, policy management, and audit evidence:

| Capability | Purpose | Candidates |
|-----------|---------|------------|
| Agent registry | Central inventory of all deployed agents, their policies, and owners | Credo AI, AgentID, or internal registry |
| Policy packs | Reusable compliance policy sets (SOC 2, ISO 27001) mapped to agent controls | Governance platform or internal policy engine |
| Audit trail (immutable) | Evidence-quality logs of every trigger, tool call, decision, and outcome | SIEM (primary system of record) + governance platform |
| Compliance dashboard | Real-time view of agent compliance status for auditors | Governance platform or internal dashboard |
| NemoClaw runtime | Kernel-level isolation for Nvidia-ecosystem clients | NemoClaw (evaluation scheduled) |

**Status:** Evaluation scheduled. For initial deployments, SIEM + Sentinel agent provides the minimum viable audit capability.

---

## 2. SOC 2 + ISO 27001 Control Mapping

| SOC 2 Trust Criteria | ISO 27001 Control | How We Address It |
|---------------------|-------------------|-------------------|
| CC6.1 — Logical access | A.9 Access control | Layer 1: RBAC (Claude Enterprise) + Layer 2: Network policies |
| CC6.3 — System boundaries | A.13 Communications security | Layer 2: Container isolation, egress allowlists |
| CC7.1 — System monitoring | A.12 Operations security | Layer 1: Usage logging + Layer 2: SIEM ingestion |
| CC7.2 — Anomaly detection | A.16 Incident management | Layer 2: Runtime monitoring + Layer 1: Sentinel alerts |
| CC8.1 — Change management | A.14 System development | Layer 1: Git workflow, PR reviews, Sentinel security review |
| CC9.1 — Risk mitigation | A.18 Compliance | Layer 1: RSP gates (threat model, risk-benefit) + Layer 3: Compliance dashboard |

---

## 3. Development Lifecycle Integration

| Phase | Layer 1 | Layer 2 | Layer 3 |
|-------|---------|---------|---------|
| **Architecture** | Threat model, ASL-aware design | Container/namespace design, network policy spec, egress policy draft | Agent registry entry |
| **Implementation** | Safety classifier handling, no safeguard circumvention | Sandbox configuration, egress allowlist finalization | Policy pack assignment |
| **Security Review** | RSP gates (Sentinel) | Infra isolation verification, policy enforcement test | Governance platform check |
| **Pre-Deployment** | Risk-benefit assessment | Container deployed with restrictions active, kill switch tested | Agent status: pending |
| **Deployment** | Agent logging active | Runtime monitoring confirmed, SIEM ingestion verified | Agent status: active |
| **Operations** | Quarterly RSP/Risk Report review | Ongoing monitoring, egress anomaly detection | Audit trail review, compliance reporting |
| **Incident** | Sentinel alert | Container termination (kill switch) | Agent status: suspended, incident logged |

---

## 4. Design-for-Exit Principles

Regardless of current vendor choices, maintain portability:

1. **Business logic is framework-neutral.** Agent workflows and tools use generic patterns, not vendor-specific SDKs. Agents call internal APIs, not raw backend systems.
2. **Security policies are separated from business logic.** Isolation policies (network, filesystem) are configuration, not code. Changing the enforcement engine does not require rewriting agents.
3. **Observability is centralized outside any single vendor.** SIEM is the system of record for audit trails. If you change runtimes, auditors see continuity in evidence.
4. **Standards-based interfaces.** MCP for tool integration, standard API patterns for model access. Provider-agnostic abstraction layers for model calls.

---

## 5. Client Advisory Application

This three-layer model serves as the foundation for enterprise AI governance advisory engagements. For each client:

1. **Assess current state** against the three layers (what governance exists, what isolation exists, what audit capability exists).
2. **Map gaps** to SOC 2 / ISO 27001 controls relevant to their compliance requirements.
3. **Recommend implementation** using the layer appropriate to their infrastructure (Azure clients → Microsoft stack guidance; Nvidia clients → NemoClaw evaluation; cloud-agnostic → Kubernetes + SIEM pattern).
4. **Deliver governance framework** adapted from this standard to the client's technology stack and compliance requirements.

---

## 6. Open Research Items

| Item | Status | Priority |
|------|--------|----------|
| NemoClaw hands-on evaluation | Scheduled | Medium — for Nvidia-ecosystem clients |
| Governance platform evaluation (Credo AI, AgentID) | Scheduled | Medium — for Layer 3 maturity |
| NIST AI RMF mapping | Deferred | Low — add when US federal clients require it |
| EU AI Act mapping | Deferred | Low — add when EU clients require it |
| Anthropic Antspace monitoring | Watch list | Low — speculative, no actionable information |
