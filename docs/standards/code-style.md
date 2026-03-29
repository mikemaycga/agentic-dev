# Code Style Standards

**Version:** 1.0 | **Status:** Active Standard

## General Principles

All code follows the principle of consistency within a project and readability above cleverness. Language-specific standards are enforced by the respective specialist agents.

## Language-Specific Standards

### TypeScript/JavaScript

| Rule | Requirement |
|------|-------------|
| Strict mode | `"strict": true` in tsconfig |
| Linting | ESLint with project-specific configuration |
| Formatting | Prettier (2-space indent, single quotes, trailing commas) |
| Return types | Explicit on all exported functions |
| Variables | `const` preferred; `let` when necessary; `var` prohibited |
| Exports | Named exports preferred over default exports |

**Enforced by:** [TypeScript Dev](../agents/specialists.md) agent

### Python

| Rule | Requirement |
|------|-------------|
| Version | Python 3.11+ required |
| Type hints | Required on all function signatures |
| Linting/Formatting | Ruff |
| Docstrings | Google-style on all public functions |
| Line length | Black-compatible (88 characters) |

**Enforced by:** [Python Dev](../agents/specialists.md) agent

### Swift

| Rule | Requirement |
|------|-------------|
| Version | Swift 5.9+ with strict concurrency checking |
| Linting | SwiftLint |
| UI framework | SwiftUI preferred for new views |
| Access control | Explicit modifiers required |

**Enforced by:** [Swift Dev](../agents/specialists.md) agent

## Universal Rules

- No commented-out code in committed files (use version control)
- No TODO comments without an associated issue number
- Error messages must be actionable (state what went wrong AND what to do about it)
- Functions over 50 lines should be evaluated for decomposition
- Files over 500 lines should be evaluated for splitting
