# Code Style Standards

**Version:** 1.0
**Date:** March 28, 2026
**Status:** Active Standard

## General Principles

All code in this environment follows the principle of consistency within a project and readability above cleverness. Language-specific standards are enforced by the respective specialist agents.

## Language-Specific Standards

### TypeScript/JavaScript
- Strict mode enabled (`"strict": true`)
- ESLint with project-specific configuration
- Prettier for formatting (2-space indent, single quotes, trailing commas)
- Explicit return types on exported functions
- `const` preferred over `let`; `var` is prohibited
- Named exports preferred over default exports

### Python
- Python 3.11+ required
- Type hints on all function signatures
- Ruff for linting and formatting
- Google-style docstrings on public functions
- Black-compatible formatting (88 char line length)

### Swift
- Swift 5.9+ with strict concurrency checking
- SwiftLint for style enforcement
- SwiftUI preferred for new views
- Explicit access control modifiers

## Universal Rules

- No commented-out code in committed files (use version control)
- No TODO comments without an associated issue number
- Error messages must be actionable (state what went wrong AND what to do about it)
- Functions over 50 lines should be evaluated for decomposition
- Files over 500 lines should be evaluated for splitting
