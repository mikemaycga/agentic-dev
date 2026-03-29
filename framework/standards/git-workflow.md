# Git Workflow Standards

**Version:** 1.0
**Date:** March 28, 2026
**Status:** Active Standard

## Branch Strategy

```
main                    # Production-ready code
├── develop             # Integration branch
│   ├── feature/*       # Feature branches (agent-created)
│   ├── fix/*           # Bug fix branches
│   └── experiment/*    # Experimental branches (safe to discard)
└── release/*           # Release candidates
```

## Commit Conventions

Format: `type(scope): description`

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `security`

All agent-generated commits include:
```
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

## Branch Protection

Required for `main` and `develop`:
- PR required (no direct commits)
- At least 1 review approval
- CI checks must pass
- Sentinel security review must pass

## PR Standards

- Title under 70 characters
- Description includes: summary, changes made, testing performed
- Link to related issues
- No draft PRs sitting for more than 5 business days without activity

## Merge Strategy

- **feature → develop:** Squash merge (clean history)
- **develop → main:** Merge commit (preserve feature boundaries)
- **fix → main:** Cherry-pick for hotfixes, then merge back to develop
