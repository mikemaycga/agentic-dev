# Security Baseline Standards

**Version:** 1.0
**Date:** March 28, 2026
**Status:** Active Standard

## Scope

This baseline applies to ALL projects unless overridden by a stricter security profile.

## Mandatory Controls

1. **Secrets Management:** No secrets, API keys, passwords, or tokens in source code. Use environment variables or a secrets vault.

2. **Git Hygiene:** `.env`, credential files, and private keys must be in `.gitignore`. Run pre-commit hooks to catch accidental secret commits.

3. **Dependency Security:** Review dependency updates before merging. Run `npm audit` / `pip audit` as part of CI.

4. **Authentication:** Use established libraries (not custom implementations) for authentication. OAuth 2.0 / PKCE for mobile clients.

5. **Data Classification:**
   - **Public:** Can be in any repository or sync location
   - **Internal:** Git repositories only (not iCloud without ADP)
   - **Confidential:** Git repositories with access controls, or local storage only
   - **Client-Confidential:** Same as Confidential, plus client-specific access restrictions

6. **iCloud Restrictions:** Client-confidential data must NOT be stored in iCloud Drive (ADP is off). Use Git repos or local storage.

## Security Review Triggers

Sentinel security review is required before:
- Any PR merge to `main` or `develop`
- Any production deployment
- Any new external dependency addition
- Any changes to authentication or authorization logic
