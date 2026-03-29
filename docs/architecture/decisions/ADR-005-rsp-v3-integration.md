# ADR-005: Anthropic RSP v3.0 Integration

**Status:** Accepted
**Date:** 2026-03-29

## Context

This development environment builds on Anthropic's Claude models. Anthropic's Responsible Scaling Policy v3.0 (effective February 24, 2026) establishes AI Safety Levels, capability thresholds, mitigation requirements, risk reporting, and governance mechanisms that affect every system built on Claude. The question was whether to treat the RSP as a reference document or to integrate its principles into the development lifecycle.

## Decision

Integrate RSP v3.0 principles across the entire development lifecycle — architecture, design, implementation, security, deployment, and ongoing operations. The RSP is not a post-hoc compliance check; its principles influence how systems are designed from inception.

Five principles adopted as framework requirements:
1. **ASL-aware design** — Systems account for active AI Safety Level safeguards
2. **Threat model documentation** — Required before AI-powered features reach production (Sentinel gate)
3. **Risk-benefit assessment** — Required before AI deployment (Sentinel gate)
4. **Agent auditability** — Multi-agent action logging as a governance requirement
5. **Model evolution planning** — Architecture includes abstraction layers for model API calls

Two items under consideration:
- RAND SL4 security benchmark (referenced, not mandated)
- Noncompliance reporting mechanisms (client advisory, not framework enforcement)

## Consequences

- Architect agent now requires threat model documentation for AI features
- Sentinel agent has three new blocking gates (threat model, risk-benefit, safeguard compliance)
- Deployer checklist includes RSP-specific items
- Larry's constraints include RSP compliance verification
- Security baseline updated to v1.1 with RSP lifecycle touchpoints table
- Quarterly review of Anthropic Risk Reports added as an operational requirement

## Alternatives Considered

- **Reference-only approach:** Rejected. RSP principles are too fundamental to relegate to a knowledge library reference when building directly on Anthropic's models.
- **Full compliance framework:** Rejected. The RSP governs Anthropic as a company, not downstream developers. We adopt the principles and the governance discipline, not the compliance obligations.

## Source

- [RSP v3.0](https://anthropic.com/responsible-scaling-policy/rsp-v3-0)
- Assessment: `knowledge-library/assessments/2026-03-29-anthropic-rsp-v3-framework-implications.md`
