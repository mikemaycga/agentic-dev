---
name: review-pr
description: |
  Reviews pull requests for code quality, security, and standards compliance. Triggers on: review, PR, pull request, code review, merge request. Does not trigger for: creating PRs, deploying, writing new code. Produces a structured review with approval status and actionable feedback.
---

## Workflow

1. **Read the PR diff** — Understand all changes, their scope, and intent.
2. **Check standards compliance** — Verify against project `.claude/rules/` and framework standards.
3. **Security scan** — Check for exposed credentials, injection vulnerabilities, insecure patterns.
4. **Test coverage** — Verify new code has adequate test coverage.
5. **Logic review** — Check for edge cases, error handling, race conditions.
6. **Documentation** — Verify public APIs and significant changes are documented.
7. **Report** — Provide structured review with APPROVE, REQUEST_CHANGES, or COMMENT status.

## Review Output Format

```
PR REVIEW: [PR title]
Status: APPROVE | REQUEST_CHANGES | COMMENT
Summary: [1-2 sentence overview]
Findings:
  - [file:line] [severity] [description]
Suggestions:
  - [optional improvement ideas]
```

## Constraints

- Review the actual diff, not just the PR description.
- Security issues are always blocking (REQUEST_CHANGES).
- Be specific — cite file and line number for every finding.
