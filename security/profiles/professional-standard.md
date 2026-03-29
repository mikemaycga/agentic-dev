# Security Profile: Professional Standard

**Status:** Default Profile
**Use When:** All projects unless a stricter profile is specified

## Controls

| Control | Setting | Notes |
|---------|---------|-------|
| Secrets in code | Blocked | Pre-commit hook + Sentinel scan |
| .env in .gitignore | Required | Verified by Sentinel |
| Dependency audit | Required before merge | `npm audit` / `pip audit` |
| Branch protection | main + develop | PR required, 1 approval, CI pass |
| iCloud for client data | Prohibited | ADP is off; client data in Git/local only |
| Production deploy gate | Human approval required | Plus QA + Sentinel sign-off |
| Credential rotation | Quarterly recommendation | Not enforced automatically |
| Code signing | Recommended for releases | Required for iOS/macOS distribution |

## Sentinel Scan Requirements

- Full codebase scan before first deployment
- Incremental scan (changed files) before each PR merge
- Dependency audit weekly (can be automated in CI)
