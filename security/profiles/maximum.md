# Security Profile: Maximum (Zero Trust)

**Status:** Available
**Use When:** Government, regulated industries, or any engagement requiring zero-trust posture

## Additional Controls (Beyond Enterprise SOC 2)

| Control | Setting | Notes |
|---------|---------|-------|
| iCloud sync | Fully prohibited | No project data in any cloud sync service |
| Network access | Allowlist only | Explicit approval for each external service |
| Code review | 2 approvals required | Including 1 from security-qualified reviewer |
| Secrets management | Vault required | HashiCorp Vault or equivalent; no env vars |
| Container hardening | Distroless base images | Minimal attack surface |
| Supply chain security | SBOM required | Software Bill of Materials for all releases |
| Data classification | Per-field classification | Every data field labeled with classification level |
| Logging | Immutable audit logs | Tamper-evident logging infrastructure |
| Session management | Short-lived tokens only | Maximum 1 hour token lifetime |
| CI/CD security | Signed commits required | GPG signing on all commits |

## Sentinel Scan Requirements

All Enterprise SOC 2 requirements, plus:
- DAST (Dynamic Application Security Testing) before each release
- Infrastructure-as-code security scanning
- Runtime security monitoring in production
- Signed artifact verification in deployment pipeline
