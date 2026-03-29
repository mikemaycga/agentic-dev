---
name: deploy
description: |
  Manages deployment workflows for staging and production environments. Triggers on: deploy, release, ship, push to production, staging. Does not trigger for: local development, building, testing. Produces a deployment execution with pre-flight checks, execution, and verification.
---

## Workflow

1. **Pre-flight checks:**
   - Verify QA Lead sign-off exists
   - Verify Sentinel security review passed
   - Verify human approval for production deployments
   - Confirm target environment and branch
2. **Build verification:** Run build process, verify artifacts are clean.
3. **Environment check:** Confirm environment variables and secrets are configured.
4. **Execute deployment** per project-specific deployment configuration.
5. **Post-deployment verification:** Health checks, smoke tests, monitoring review.
6. **Report:** Deployment status, environment, version, any issues.

## Constraints

- Never skip pre-flight checks.
- Production deployments require explicit human approval — no exceptions.
- Always have a documented rollback plan before executing.
- Never store secrets in deployment scripts.
