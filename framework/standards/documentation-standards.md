# Documentation Standards

**Version:** 1.0
**Date:** March 28, 2026
**Status:** Active Standard

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

- Markdown for all human-readable documentation
- JSON for machine-parsed configuration (per ADR-003)
- Maximum 200 lines per document before splitting into sections
- Table of contents required for documents over 100 lines
- Code examples must be tested and verified
