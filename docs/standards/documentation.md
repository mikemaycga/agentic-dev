# Documentation Standards

**Version:** 1.0 | **Status:** Active Standard

## Principles

- Documentation answers a specific question. If it does not answer a question, it does not belong.
- Scenario-based help over traditional manuals.
- Visual aids (diagrams, mindmaps) where they add clarity.
- Keep documentation close to the code it describes.

## Location Rules

| Content Type | Location |
|-------------|----------|
| Project-specific docs | `project-root/docs/` |
| Framework standards | `~/agentic-dev/framework/standards/` |
| Architecture decisions | `~/agentic-dev/framework/architecture/decisions/` |
| External knowledge | `~/agentic-dev/knowledge-library/` |
| Help content | `project-root/docs/help-content/` |

## File Naming

- Use lowercase with hyphens: `api-design-guide.md`
- Date-prefix for time-sensitive content: `2026-03-28-assessment-name.md`
- ADR naming: `ADR-NNN-short-description.md`

## Content Standards

| Rule | Requirement |
|------|-------------|
| Format | Markdown for all human-readable documentation |
| Configuration | JSON for machine-parsed files (per [ADR-003](../architecture/decisions/ADR-003-document-formats.md)) |
| Maximum length | 200 lines per document before splitting |
| Table of contents | Required for documents over 100 lines |
| Code examples | Must be tested and verified |

## Format Decision (ADR-003)

Markdown is used for model-consumed files (CLAUDE.md, agent definitions, skills, standards). JSON is used for application-parsed files (settings.json, hooks.json, qa-gates.json). This aligns with Anthropic's documented file format conventions and minimizes context token usage.
