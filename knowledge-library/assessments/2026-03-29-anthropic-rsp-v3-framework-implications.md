# Contrarian Analyst Assessment: Anthropic RSP v3.0 — Framework Implications

**Date:** March 29, 2026
**Source:** Anthropic Responsible Scaling Policy Version 3.0, effective February 24, 2026
**URL:** https://anthropic.com/responsible-scaling-policy/rsp-v3-0
**Analyst:** Contrarian Analyst (Claude Opus 4.6)
**Document Type:** Primary source (Anthropic official policy)

---

## 1. Source Credibility

This is a first-party Anthropic policy document — the highest credibility tier in our framework. It is not a blog post, tutorial, or third-party interpretation. It is the governing policy for how Anthropic develops and deploys AI systems. As such, it does not require contrarian skepticism on factual claims — it IS the authoritative source. The assessment here focuses on implications for our framework, not on challenging Anthropic's own policy.

---

## 2. Policy Summary

RSP v3.0 is Anthropic's voluntary framework for managing catastrophic risks from advanced AI. Major components:

1. **Industry-Wide Safety Recommendations** — A capabilities-to-mitigations map with three columns: capability thresholds, Anthropic's unilateral plans, and industry-wide recommendations.
2. **Frontier Safety Roadmap** — Publicly-graded targets across Security, Alignment, Safeguards, and Policy.
3. **Risk Reports** — Published every 3-6 months with detailed model safety profiles, subject to external review.
4. **Governance** — Responsible Scaling Officer (RSO), Board oversight, noncompliance reporting, annual third-party procedural review.

Key shift from v2: Separates what Anthropic can do unilaterally from what requires industry coordination. Acknowledges that "pre-set capability levels proved far more ambiguous than anticipated."

---

## 3. Capability Thresholds and Mitigations (The Three-Column Table)

| Threshold | Anthropic's Plan | Industry Recommendation |
|-----------|-----------------|------------------------|
| **Non-novel chemical/biological weapons** | ASL-3 protections: Constitutional Classifiers, access controls, red-teaming, bug bounties, threat intelligence | Frontier developers must argue users won't cause catastrophic harm via product surfaces or model weight theft |
| **Novel chemical/biological weapons** | ASL-3+ protections, expanded use case coverage, policy recommendations for early detection, threat sharing with policymakers | Higher security standard: even well-resourced threat actors unlikely to jailbreak or steal model weights. RAND SL4 security. |
| **High-stakes sabotage** | Detail system capabilities, monitoring practices, risk levels in Risk Reports | Internal compartmentalization, code review, capability assessments demonstrating models cannot carry out irreversible sabotage, behavioral monitoring |
| **Automated R&D in key domains** | Moonshot security R&D, "eyes on everything" internal monitoring, systematic alignment assessments, adversarial red-teaming, publish Risk Reports with external review | RAND SL4 security, internal Usage Policy, compartmentalization restricting even CEO access, evidence models not trained toward dangerous goals |

---

## 4. Claims Relevant to Our Framework

### Claim 1: Downstream developers inherit ASL-3 safeguards
**Status:** Fact (not a claim — this is operational reality)
**Implication:** Every application built on Claude inherits Constitutional Classifiers and content filtering. Architecture must account for these as constraints, not obstacles. Systems should gracefully handle safety classifier triggers rather than treating them as bugs.
**Framework Impact:** Architecture, Code

### Claim 2: Model capabilities and restrictions will change over time
**Status:** Fact — RSP is explicitly a "living document" and safeguards escalate with capabilities
**Implication:** Systems built on Claude must be designed for model behavior evolution. Hardcoded assumptions about what Claude can or cannot do will break. API integrations need abstraction layers and graceful degradation.
**Framework Impact:** Architecture, Design

### Claim 3: Frontier developers should argue that users won't cause catastrophic harm via product surfaces
**Status:** Industry recommendation (not binding on downstream developers, but establishes the standard of care)
**Implication:** When building products on Claude for enterprise clients, the architecture should include usage monitoring, abuse detection, and clear boundaries on what the AI system can access and do. This is directly relevant to Mike's client advisory work — enterprise AI governance should address this.
**Framework Impact:** Architecture, Security, Client Advisory

### Claim 4: Security should be calibrated against RAND SL4 at higher capability levels
**Status:** Industry recommendation for future capability thresholds
**Implication:** Our security profiles should reference the RAND security level framework as a benchmark, particularly for enterprise-soc2 and maximum profiles. Currently our profiles do not reference RAND SLs.
**Framework Impact:** Security Profiles

### Claim 5: Risk-benefit determination is required before deployment
**Status:** Anthropic's own commitment — "we will explain whether, and if so why, we believe the identified risks are justified by corresponding benefits"
**Implication:** This framework can be adapted for enterprise AI governance. Before deploying AI-powered features, enterprises should document a risk-benefit assessment. This should be a gate in the deployment process, not an afterthought.
**Framework Impact:** Deployment, Client Advisory

### Claim 6: Threat model identification should be explicit and documented
**Status:** Anthropic commitment — Risk Reports must document "criteria for determining which catastrophic risks we assess" and "relevant threat models"
**Implication:** Enterprise AI projects should document their threat models explicitly. Not every project faces catastrophic risk, but the discipline of threat model documentation improves security posture at every level. Sentinel should require threat model documentation as part of security review.
**Framework Impact:** Security, Architecture

### Claim 7: Internal monitoring and "eyes on everything" for AI development activities
**Status:** Anthropic's plan for higher-capability models
**Implication:** For enterprises using AI agents with significant autonomy (like our multi-agent architecture), logging and monitoring of agent actions becomes a governance requirement, not just a debugging aid. Larry's delegations, Sentinel's reviews, and deployment actions should all be auditable.
**Framework Impact:** Architecture, Governance, All Agents

### Claim 8: Noncompliance reporting and whistleblower protection
**Status:** Anthropic governance commitment
**Implication:** For enterprise clients, AI governance frameworks should include mechanisms for reporting AI system misbehavior or policy violations. This is particularly relevant for SOC 2 and regulated industry engagements.
**Framework Impact:** Client Advisory, Security Profiles

---

## 5. Assessment Summary

| # | Claim | Status | Framework Impact |
|---|-------|--------|-----------------|
| 1 | ASL-3 safeguards inherited | Adopt — integrate into architecture standards | Architecture, Code |
| 2 | Model behavior evolves | Adopt — design for change | Architecture, Design |
| 3 | Product surface safety argument | Adopt — enterprise governance standard | Architecture, Security, Advisory |
| 4 | RAND SL4 security benchmark | Consider — reference in security profiles | Security |
| 5 | Risk-benefit gate before deploy | Adopt — add deployment gate | Deployment |
| 6 | Explicit threat model documentation | Adopt — Sentinel requirement | Security, Architecture |
| 7 | Agent action logging/monitoring | Adopt — governance requirement | All Agents, Architecture |
| 8 | Noncompliance reporting mechanisms | Consider — client advisory material | Advisory, Security |

**Adopted:** 5 (Claims 1, 2, 3, 5, 6, 7)
**Considering:** 2 (Claims 4, 8)
**Archived:** 0
**Rejected:** 0

---

## 6. Lifecycle Integration Recommendation

The RSP should not sit in the knowledge library as a reference. Its principles should be integrated at specific points in the development lifecycle:

| Lifecycle Phase | RSP Touchpoint | Enforced By |
|-----------------|---------------|-------------|
| **Architecture & Design** | Threat model documentation, ASL-aware system design, model behavior evolution planning | Architect agent |
| **Implementation** | Graceful handling of safety classifier triggers, no circumvention of model safeguards, abstraction layers for model API calls | Specialist agents, Code rules |
| **Security Review** | Threat model verification, RAND SL reference (enterprise), usage monitoring architecture | Sentinel agent |
| **Pre-Deployment** | Risk-benefit assessment gate, safety argument for product surfaces | QA Lead + Sentinel |
| **Deployment** | Agent action logging enabled, monitoring architecture verified, rollback plan for model behavior changes | Deployer agent |
| **Ongoing Operations** | Quarterly review of Anthropic Risk Reports for model changes, ASL escalation monitoring | Scheduled task + Analyst |
| **Client Advisory** | RSP-informed enterprise AI governance framework, noncompliance reporting recommendations | Client deliverables skill |

---

## 8. Decisions Made

| # | Item | Decision | Updated Files |
|---|------|----------|---------------|
| 1 | ASL-3 safeguard integration | **Adopted** — Architecture must account for safety classifiers as features | security-baseline.md, architect.md |
| 2 | Model evolution planning | **Adopted** — Abstraction layers and graceful degradation required | security-baseline.md, architect.md |
| 3 | Product surface safety argument | **Adopted** — Enterprise AI governance standard | security-baseline.md, client-deliverables SKILL.md |
| 4 | RAND SL4 security benchmark | **Considering** — Reference added to enterprise profiles, not mandated | security-baseline.md |
| 5 | Risk-benefit deployment gate | **Adopted** — New Sentinel blocking gate + Deployer checklist item | sentinel.md, deployer.md, security-baseline.md |
| 6 | Threat model documentation | **Adopted** — New Sentinel blocking gate + Architect requirement | sentinel.md, architect.md, security-baseline.md |
| 7 | Agent action logging/auditability | **Adopted** — Pre-deployment requirement | larry.md, deployer.md, security-baseline.md |
| 8 | Noncompliance reporting | **Considering** — Client advisory material, not framework enforcement | No file changes yet |

---

## 9. Sources

- [RSP v3.0 Full Document (PDF)](https://anthropic.com/responsible-scaling-policy/rsp-v3-0)
- [RSP v3.0 Announcement](https://www.anthropic.com/news/responsible-scaling-policy-v3)
- [RSP Updates Page](https://www.anthropic.com/rsp-updates)
