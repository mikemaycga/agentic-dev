# ADR-004: Skill-Building Standards

**Status:** Accepted
**Date:** 2026-03-28

## Context

Skills are a primary extension mechanism for Claude Code. Without governance, skills tend toward bloat (exceeding context limits), poor discoverability (vague descriptions), and stale content. Anthropic documents a 500-line hard maximum and progressive disclosure architecture but does not prescribe development workflow governance.

## Decision

Adopt comprehensive skill-building standards: 200-line target / 500-line hard maximum for SKILL.md, three-tier progressive disclosure, three-part description framework (trigger/negative trigger/outcome), evaluation-driven development, and a self-improving skills governance pattern (Option A: fully manual) for pilot skills.

Full standard: `framework/standards/skill-building-standards.md`

## Consequences

- All skills must stay under 500 lines (hard max) with 200 lines as the efficiency target
- Descriptions follow trigger/negative-trigger/outcome framework for accurate activation
- Pilot skills (architecture-review, client-deliverables) use human-gated learnings.md files
- Weekly Friday pruning reviews staging learnings for promotion

## Alternatives Considered

- **500-line max only:** Less disciplined, no progressive disclosure enforcement
- **200-line hard max:** Too restrictive for legitimately complex skills
- **No standard:** Leads to context bloat and poor skill quality over time
- **Automated self-improvement (Option C):** Deferred to post-pilot; too much autonomy without proven governance
