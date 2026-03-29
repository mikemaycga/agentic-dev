---
name: fix-issue
description: |
  Diagnoses and fixes bugs from GitHub issues or error reports. Triggers on: bug, fix, issue, error, broken, regression, crash, exception. Does not trigger for: feature requests, refactoring, documentation. Produces a targeted fix with tests that verify the bug is resolved.
---

## Workflow

1. **Read the issue** — Understand the reported bug, reproduction steps, and expected behavior.
2. **Locate the root cause** — Use Grep/Glob to find relevant code. Read surrounding context.
3. **Verify the bug** — Run existing tests or reproduce the issue to confirm it exists.
4. **Implement the fix** — Make the minimum change necessary to resolve the issue.
5. **Write a regression test** — Create a test that would have caught this bug.
6. **Run the full test suite** — Confirm no regressions.
7. **Report** — Summarize: root cause, fix applied, test added, any related concerns.

## Constraints

- Minimum viable fix. Do not refactor unrelated code.
- Every fix must include a regression test.
- If the root cause is unclear, report findings and ask for guidance rather than guessing.
