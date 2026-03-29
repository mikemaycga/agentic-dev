# Skill Catalog

Skills are the primary extension mechanism for Claude Code. Each skill provides a specialized capability that agents can invoke during task execution.

## Active Skills

| Skill | Trigger Keywords | Description |
|-------|-----------------|-------------|
| **fix-issue** | bug, fix, issue, error, broken, regression | Diagnoses and fixes bugs from GitHub issues or error reports |
| **review-pr** | review, PR, pull request, code review | Reviews pull requests for code quality, security, and standards |
| **deploy** | deploy, release, ship, push to production | Manages deployment workflows with pre-flight checks |
| **security-scan** | security scan, vulnerability, credential scan | Runs security scans with severity-rated findings |
| **architecture-review** | architecture review, design review, structure | Reviews architecture against framework standards |
| **client-deliverables** | client deliverable, proposal, assessment, report | Creates professional C-Suite deliverables |

## Skill Details

### fix-issue

**Triggers:** bug, fix, issue, error, broken, regression, crash, exception
**Does NOT trigger for:** feature requests, refactoring, documentation

Workflow: Read issue → Locate root cause → Verify bug → Implement fix → Write regression test → Run full suite → Report.

Constraint: Minimum viable fix. Every fix must include a regression test.

### review-pr

**Triggers:** review, PR, pull request, code review, merge request
**Does NOT trigger for:** creating PRs, deploying, writing new code

Workflow: Read diff → Check standards → Security scan → Test coverage → Logic review → Documentation check → Structured report.

Output: `APPROVE`, `REQUEST_CHANGES`, or `COMMENT` with file:line citations.

### deploy

**Triggers:** deploy, release, ship, push to production, staging
**Does NOT trigger for:** local development, building, testing

Workflow: Pre-flight checks (QA + Sentinel + human approval) → Build verification → Environment check → Execute → Post-deployment verification → Report.

Constraint: Production deployments require explicit human approval — no exceptions.

### security-scan

**Triggers:** security scan, vulnerability check, credential scan, secrets detection
**Does NOT trigger for:** code review, deployment

Workflow: Determine scope → Secrets detection → Dependency audit → Configuration review → Generate severity-sorted report.

Output: PASS/FAIL/WARN with findings sorted Critical → High → Medium → Low.

### architecture-review

**Triggers:** architecture review, design review, structure review, framework compliance
**Does NOT trigger for:** code-level review, security audit

Self-improving skill with learnings governance. Reviews project structure, framework alignment, Anthropic best practices, and cross-references against standards.

### client-deliverables

**Triggers:** client deliverable, proposal, assessment, client report, executive summary
**Does NOT trigger for:** internal documentation, code artifacts

Self-improving skill for C-Suite deliverables. Applies professional formatting, data-driven recommendations, and security checks for client-confidential content.

## Building New Skills

See [Skill Building Standards](../standards/skill-building.md) and [ADR-004](../architecture/decisions/ADR-004-skill-building.md) for the governance framework.
