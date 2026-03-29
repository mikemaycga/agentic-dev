# ADR-003: Document Format Standards

**Status:** Accepted
**Date:** 2026-03-28

## Context

The environment contains files consumed by both Claude (LLM) and applications (parsers). Different formats optimize for different consumers. Markdown is natural for LLMs but lacks schema validation. JSON provides structure but wastes 30-40% more context tokens.

## Decision

Markdown for model-consumed files (CLAUDE.md, agent definitions, skills, standards). JSON for application-parsed files (settings.json, hooks.json, qa-gates.json). This aligns with Anthropic's documented file format conventions.

## Consequences

- Agent definitions, skills, and CLAUDE.md files use markdown with YAML frontmatter
- Configuration files (settings, hooks) use JSON with schemas
- Standards documents use markdown
- Machine-enforceable thresholds use JSON (qa-gates.json)

## Alternatives Considered

- **All JSON:** Rejected — fights Anthropic's markdown-based tooling, wastes context tokens
- **All markdown:** Rejected — no schema validation for machine-consumed configs
- **YAML everywhere:** Rejected — not Anthropic's convention, limited tooling support
