# Full-Stack Web Project

## Project Type
Full-stack web application (TypeScript/React frontend, Node.js backend)

## Standards
@framework/standards/code-style.md
@framework/standards/testing-standards.md
@framework/standards/security-baseline.md
@framework/standards/git-workflow.md

## Tech Stack
- **Frontend:** React + TypeScript + Vite (or Next.js)
- **Backend:** Node.js + Express (or Fastify) + TypeScript
- **Database:** PostgreSQL (default) or as specified
- **Testing:** Vitest (unit), Playwright (E2E)
- **CI/CD:** GitHub Actions

## Project Conventions
- API routes follow REST conventions: `/api/v1/[resource]`
- Frontend components in `src/components/` with co-located tests
- Backend routes in `src/routes/` with controller/service separation
- Database migrations in `src/db/migrations/`
- Environment variables documented in `.env.example`

## Security Profile
Default: professional-standard. Override in CLAUDE.local.md if client requires stricter profile.

## Deployment
- Staging: automatic on PR merge to develop
- Production: manual approval required
