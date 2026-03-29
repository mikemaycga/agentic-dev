# Testing Standards

**Version:** 1.0 | **Status:** Active Standard

## Coverage Requirements

| Level | Minimum Coverage | Notes |
|-------|-----------------|-------|
| Unit Tests | 80% line coverage | Required for all new code |
| Integration Tests | Critical paths covered | API endpoints, database operations, external service calls |
| E2E Tests | Happy path + top 3 error paths | Where applicable |

## Testing Principles

1. **Tests prove behavior, not implementation.** Test what the code does, not how it does it.
2. **Every bug fix includes a regression test.** No exceptions.
3. **Tests are documentation.** Name tests to describe the behavior they verify.
4. **Fast feedback.** Unit tests must run in under 30 seconds for the full suite.

## Test Naming Convention

Format: `[unit under test]_[scenario]_[expected result]`

```
calculateTotal_withEmptyCart_returnsZero
validateEmail_withMissingDomain_throwsValidationError
deployAgent_withoutSentinelApproval_blocksDeployment
```

## Quality Gates

[QA Lead](../agents/roster.md) enforces these gates before deployment approval:

| Gate | Threshold | Blocking |
|------|-----------|----------|
| All tests pass | 100% | Yes |
| Coverage drop | No more than 2% from baseline | Yes |
| Skipped tests | None without documented justification | Yes |
| Security tests | Verified by Sentinel | Yes |

These thresholds are also defined in machine-enforceable format in `framework/standards/qa-gates.json`.
