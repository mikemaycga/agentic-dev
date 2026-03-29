---
name: security-scan
description: |
  Runs a security scan on a codebase or specific files. Triggers on: security scan, vulnerability check, credential scan, secrets detection, compliance check. Does not trigger for: code review (use review-pr), deployment (use deploy). Produces a security report with findings, severity ratings, and remediation steps.
---

## Workflow

1. **Determine scope** — Full codebase or specific files/directories.
2. **Secrets detection:**
   - Scan for patterns: API keys (`AKIA`, `sk-`, `ghp_`), passwords, tokens, private keys
   - Check `.env` files are in `.gitignore`
   - Verify no secrets in CLAUDE.md, agent definitions, or skill files
3. **Dependency audit:**
   - `npm audit` for Node.js projects
   - `pip audit` or `safety check` for Python projects
   - Check for known vulnerable versions
4. **Configuration review:**
   - CORS settings, authentication configs, permission boundaries
   - Database connection security
5. **Generate report** with findings sorted by severity (Critical → High → Medium → Low).

## Output Format

```
SECURITY SCAN: [scope]
Profile: [active security profile]
Date: [timestamp]
Status: PASS | FAIL | WARN

CRITICAL: [count]
HIGH: [count]
MEDIUM: [count]
LOW: [count]

Findings:
[numbered list with severity, location, description, remediation]
```

## Constraints

- Never downgrade a Critical or High finding without human approval.
- Always check the active security profile for project-specific requirements.
