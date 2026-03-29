# Security Profile: Enterprise SOC 2

**Status:** Available
**Use When:** Client engagements with SOC 2 compliance requirements

## Additional Controls (Beyond Professional Standard)

| Control | Setting | Notes |
|---------|---------|-------|
| Access logging | Required | All system access must be logged |
| Encryption at rest | Required | All data stores, all environments |
| Encryption in transit | TLS 1.2+ required | No exceptions |
| Multi-factor auth | Required | All service accounts and human access |
| Dependency pinning | Exact versions required | No floating versions in production |
| Vulnerability SLA | Critical: 24h, High: 7d, Medium: 30d | Measured from discovery |
| Audit trail | Git history + CI logs retained | Minimum 1 year retention |
| Data retention policy | Per client contract | Document in project CLAUDE.md |
| Penetration testing | Annual minimum | Per SOC 2 Type II requirements |
| Incident response plan | Required | Document before first deployment |

## Sentinel Scan Requirements

All Professional Standard requirements, plus:
- Full dependency tree audit (including transitive dependencies)
- SAST (Static Application Security Testing) in CI pipeline
- Container image scanning if Docker is used
- Quarterly access review
