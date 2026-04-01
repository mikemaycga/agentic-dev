# Global User-Level Instructions

You are operating within Mike May's agentic development environment. This file applies to ALL Claude sessions across all projects.

## Identity & Context

- **Owner:** Mike May — Fractional CIO/CTO and AI Consultant
- **Role:** C-Suite advisor on AI strategy, data, leadership, and process design for medium-to-enterprise companies
- **Communication Standard:** Professional and clinical. No casual or "buddy" responses. Verify all claims — zero tolerance for hallucination.

## Framework Location

- Framework root: `~/agentic-dev/` (this repository)
- Global agents: `~/agentic-dev/agents/` (symlinked to `~/.claude/agents/`)
- Global skills: `~/agentic-dev/skills/` (symlinked to `~/.claude/skills/`)
- Standards: `~/agentic-dev/framework/standards/`
- Knowledge library: `~/agentic-dev/knowledge-library/` (separate private repo: mikemaycga/agentic-dev-knowledge)

## Agent Architecture

This environment uses the Orchestrator-Worker pattern. Larry is the primary orchestrator. Do not spawn subagents that spawn other subagents — Anthropic documents that subagents cannot spawn subagents. Larry delegates directly to all workers.

### Agent Roster

| Agent | Role | Model |
|-------|------|-------|
| larry | Orchestrator — task decomposition, delegation, synthesis | opus |
| architect | Architecture design, system planning, ADR creation | opus |
| sentinel | Security scanning, credential detection, compliance review | sonnet |
| qa-lead | Testing strategy, quality gates, coverage validation | sonnet |
| deployer | Build, deploy, CI/CD pipeline management | sonnet |
| doc-writer | Documentation, help content, video scripts, visual aids | sonnet |
| analyst | Contrarian analysis of external knowledge sources | opus |
| guide | Help agent — answers user questions about the environment | sonnet |

## Knowledge Library Index

The knowledge library (`~/agentic-dev/knowledge-library/`) is a private repository containing Contrarian Analyst assessments, archived research, and adoption decisions. When asked about any of these topics, read the relevant assessment file.

### Assessments

| Date | Assessment | Key Decisions |
|------|-----------|---------------|
| 2026-03-29 | `assessments/2026-03-29-anthropic-rsp-v3-framework-implications.md` | 5 principles adopted, RSP lifecycle integration (ADR-005) |
| 2026-03-29 | `assessments/2026-03-29-nemoclaw-runtime-isolation-landscape.md` | Pattern adopted (deny-by-default), product deferred. Three-layer governance (ADR-006) |
| 2026-03-29 | `assessments/2026-03-29-autoresearch-pattern-assessment.md` | Adopted as medium-priority framework tool for measurable optimization problems |
| 2026-04-01 | `assessments/2026-04-01-paperclip-agent-operations-assessment.md` | Watch list — do not adopt yet. Re-evaluate Q3 2026. Potential Layer 3 governance dashboard |

### Archived Articles

| Date | Article | Source |
|------|---------|--------|
| 2026-03-29 | `articles/2026-03-29-nemoclaw-anthropic-runtime-isolation-research.md` | Perplexity research on NemoClaw + Anthropic runtime isolation |

## Standards References

Import these in project-level CLAUDE.md files as needed:

- @framework/standards/skill-building-standards.md (ADR-004)
- @framework/standards/document-format-standards.md (ADR-003)
- @framework/standards/code-style.md
- @framework/standards/security-baseline.md
- @framework/standards/testing-standards.md
- @framework/standards/git-workflow.md

## Cross-Machine Sync

- **Public framework:** Git via GitHub (`mikemaycga/agentic-dev`). All code, agents, skills, standards, docs.
- **Private knowledge library:** Separate private repo (`mikemaycga/agentic-dev-knowledge`). Assessments, archived research, adoption decisions.
- **Secondary sync:** iCloud Drive for non-Git content only (Cowork outputs, large media).
- **Sync script:** `bash ~/agentic-dev/sync-to-live.sh` handles both repos + docs deployment.
- **Never place `.git` directories inside iCloud-synced folders.**
- **Client-confidential deliverables:** Git repos or local storage only (ADP is off).

## Security Posture

Default profile: `security/profiles/professional-standard.md`. Override per-project or per-client as needed.

- Never commit secrets, credentials, API keys, or .env files
- Run Sentinel security scan before any PR merge
- Client SOC 2 engagements use `security/profiles/enterprise-soc2.md`

## Commit Conventions

All agent-generated commits include a `Co-Authored-By` trailer:
```
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

Use conventional commit format: `type(scope): description`

Types: feat, fix, refactor, test, docs, chore, security
