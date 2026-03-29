---
name: architecture-review
description: |
  Reviews project architecture against framework standards and Anthropic best practices. Triggers on: architecture review, design review, structure review, framework compliance. Does not trigger for: code-level review (use review-pr), security audit (use security-scan). Produces an architecture assessment with compliance status and improvement recommendations.
---

## Self-Improving Skill — Pilot

This skill participates in the self-improving skills governance framework (Option A: fully manual).

- **learnings.md**: Active learnings that inform review behavior (≤50 lines)
- **learnings-staging.md**: Proposed learnings awaiting human review during weekly Friday pruning

### Adding a Learning

After each architecture review, if a pattern or insight would improve future reviews, append it to `learnings-staging.md` in this format:

```
- [YYYY-MM-DD] [pattern/insight] — [context where it applies]
```

Do NOT modify `learnings.md` directly. All promotions happen during weekly pruning.

---

## Workflow

1. **Read project structure** — Map the project's file organization.
2. **Check framework alignment:**
   - CLAUDE.md present and under 200 lines
   - `.claude/` directory follows per-project structure (Section 4.1)
   - Agent definitions use correct YAML frontmatter format
   - Skills follow ADR-004 standards
3. **Anthropic best practices check:**
   - Progressive disclosure implemented
   - No bloated context files
   - Simplicity principle honored
4. **Cross-reference standards** in `framework/standards/`
5. **Report** with compliance score and specific recommendations.

## Constraints

- Anthropic's documentation is the primary authority.
- Flag deviations explicitly — do not silently ignore non-compliance.
- Recommendations must cite the specific standard or Anthropic source.
