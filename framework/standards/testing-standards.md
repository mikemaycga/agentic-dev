# Testing Standards

**Version:** 1.0
**Date:** March 28, 2026
**Status:** Active Standard

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

Example: `calculateTotal_withEmptyCart_returnsZero`

## Quality Gates

QA Lead enforces these gates before deployment approval:
- All tests pass
- Coverage does not drop more than 2% from baseline
- No skipped tests without documented justification
- Security-related tests verified by Sentinel
