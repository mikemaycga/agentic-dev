# Security Baseline Standards

**Version:** 1.1
**Date:** March 29, 2026
**Status:** Active Standard
**RSP Alignment:** Anthropic Responsible Scaling Policy v3.0 (February 24, 2026)

## Scope

This baseline applies to ALL projects unless overridden by a stricter security profile.

## Anthropic RSP v3.0 Alignment

This environment builds on Anthropic's Claude models, which operate under Anthropic's Responsible Scaling Policy. The RSP establishes AI Safety Levels (ASLs), capability thresholds, and mitigation requirements that affect every system built on Claude. The following principles from RSP v3.0 are integrated into this baseline:

1. **ASL-3 safeguards are inherited.** All Claude models currently operate under ASL-3 protections (Constitutional Classifiers, content filtering, access controls). Systems must be designed to work with these safeguards, not around them. Safety classifier triggers must be handled gracefully in application code — they are features, not bugs.

2. **Model behavior will evolve.** Anthropic commits to maintaining or strengthening safeguards over time. Architecture must not hardcode assumptions about model capabilities or restrictions. Use abstraction layers for model API calls; implement graceful degradation when model behavior changes.

3. **Threat model documentation is required.** Before any AI-powered feature reaches production, the project must document its threat model: what risks exist, what mitigations are in place, and what residual risk is accepted. Sentinel enforces this gate.

4. **Risk-benefit assessment before deployment.** Following Anthropic's own framework, AI-powered features require a documented risk-benefit determination before production deployment. This is a gate, not a recommendation.

5. **Agent actions must be auditable.** Multi-agent systems (Larry + specialists) must log delegations, decisions, and outcomes. This aligns with Anthropic's "eyes on everything" principle for AI development activities.

6. **Monitor Anthropic's Risk Reports.** Anthropic publishes Risk Reports every 3-6 months. These may describe changes to model capabilities, new safeguards, or escalated ASL requirements that affect downstream systems. The framework includes a quarterly review cycle for these reports.

**Full assessment:** `knowledge-library/assessments/2026-03-29-anthropic-rsp-v3-framework-implications.md`

## Mandatory Controls

1. **Secrets Management:** No secrets, API keys, passwords, or tokens in source code. Use environment variables or a secrets vault.

2. **Git Hygiene:** `.env`, credential files, and private keys must be in `.gitignore`. Run pre-commit hooks to catch accidental secret commits.

3. **Dependency Security:** Review dependency updates before merging. Run `npm audit` / `pip audit` as part of CI.

4. **Authentication:** Use established libraries (not custom implementations) for authentication. OAuth 2.0 / PKCE for mobile clients.

5. **Data Classification:**
   - **Public:** Can be in any repository or sync location
   - **Internal:** Git repositories only (not iCloud without ADP)
   - **Confidential:** Git repositories with access controls, or local storage only
   - **Client-Confidential:** Same as Confidential, plus client-specific access restrictions

6. **iCloud Restrictions:** Client-confidential data must NOT be stored in iCloud Drive (ADP is off). Use Git repos or local storage.

## Security Review Triggers

Sentinel security review is required before:
- Any PR merge to `main` or `develop`
- Any production deployment
- Any new external dependency addition
- Any changes to authentication or authorization logic
- Any new AI-powered feature reaching production (threat model + risk-benefit gate)
- Any change to model API integration patterns

## RSP Lifecycle Touchpoints

The RSP is not a post-hoc security check. Its principles influence every phase of development:

| Phase | RSP Requirement | Gate Owner |
|-------|----------------|------------|
| Architecture & Design | Document threat model; design for ASL safeguard compatibility; plan for model behavior evolution | Architect |
| Implementation | Handle safety classifier responses gracefully; no safeguard circumvention; abstract model API calls | Specialist agents |
| Security Review | Verify threat model; validate usage monitoring; check RAND SL alignment for enterprise clients | Sentinel |
| Pre-Deployment | Risk-benefit assessment documented; safety argument for product surfaces; agent logging verified | QA Lead + Sentinel |
| Deployment | Monitoring active; agent audit trail confirmed; rollback plan accounts for model behavior changes | Deployer |
| Ongoing Operations | Quarterly review of Anthropic Risk Reports; ASL escalation monitoring; threat model updates | Scheduled task |
| Client Advisory | RSP-informed AI governance framework; noncompliance reporting guidance; ASL awareness | Client deliverables skill |
