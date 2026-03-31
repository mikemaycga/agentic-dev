# Project Documentation Standards

**Version:** 1.0
**Date:** March 31, 2026
**Status:** Active Standard

## Purpose

Every managed project must maintain two living documents that answer: "What does this project do today?" and "What changed and when?" Git history alone is insufficient — it requires archaeology to extract project state. These documents provide immediate visibility for the project owner, collaborators, and future Claude sessions.

---

## Required Documents

### 1. CHANGELOG.md

**Location:** Project root
**Format:** [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
**Updated:** Every commit that changes user-visible behavior

#### Structure

```markdown
# Changelog

## [Unreleased]

## [X.Y.Z] - YYYY-MM-DD

### Added
- New features (user-visible capabilities)

### Changed
- Modifications to existing features

### Fixed
- Bug fixes (describe the symptom that was resolved)

### Removed
- Features or capabilities that were removed

### Security
- Vulnerability fixes or security improvements
```

#### Rules

| Rule | Rationale |
|------|-----------|
| One entry per user-visible change | Internal refactors go in git history, not the changelog |
| Entries describe behavior, not implementation | "Fixed query results not loading" not "Changed async Task to use MainActor" |
| Most recent version at the top | Scannable without scrolling |
| Group by Added/Changed/Fixed/Removed/Security | Consistent with Keep a Changelog standard |
| Date every release | ISO 8601 format (YYYY-MM-DD) |
| Use [Unreleased] section for work in progress | Moves to a versioned section on release |

#### Version Numbering

Use semantic versioning (MAJOR.MINOR.PATCH):
- **MAJOR** — breaking changes, architecture shifts, data migrations requiring user action
- **MINOR** — new features, new screens, new integrations
- **PATCH** — bug fixes, UI polish, performance improvements

Pre-1.0 projects use 0.Y.Z where Y increments with each feature batch.

---

### 2. FEATURE-INVENTORY.md

**Location:** Project root
**Format:** Markdown with status tables
**Updated:** Every commit that adds, completes, or defers a feature

#### Structure

```markdown
# Feature Inventory

**Last updated:** YYYY-MM-DD
**App version:** X.Y.Z

## Status Key

| Status | Meaning |
|--------|---------|
| Shipped | In the current build, functional |
| Partial | Built but incomplete or limited |
| Planned | Approved, not yet built |
| Backlog | Acknowledged, not prioritized |
| Deferred | Explicitly deferred with reason |

## [Area Name]

| Feature | Status | Notes |
|---------|--------|-------|
| Feature name | Status | Implementation details or constraints |
```

#### Rules

| Rule | Rationale |
|------|-----------|
| Organize by functional area | Matches how users think about the product |
| Every feature gets a row | Nothing is "obvious" — if it exists, document it |
| Notes column explains constraints | "Gmail MCP lacks send — drafts only" is actionable |
| Deferred items include reason | Prevents re-litigating past decisions |
| Include an Architecture Summary section | Tech stack, file counts, integration points |
| Update the "Last updated" date on every edit | Stale dates signal stale content |

#### Status Transitions

```
Backlog → Planned → Partial → Shipped
                  → Deferred (with reason)
```

Features should not skip from Backlog directly to Shipped without appearing as Planned first, unless they are trivial fixes.

---

## Agent Responsibilities

| Agent | Responsibility |
|-------|---------------|
| **Any implementing agent** | Update CHANGELOG.md in the same commit as code changes |
| **Larry (orchestrator)** | Update FEATURE-INVENTORY.md when delegating or completing features |
| **doc-writer** | Audit both documents for accuracy on request |
| **qa-lead** | Verify both documents are current before deployment approval |

---

## Enforcement

- Both documents must exist before a project's first PR to `main`
- QA Lead checks both documents are current as a quality gate
- Stale documents (>5 business days without update during active development) are flagged

---

## Integration with Other Standards

| Standard | Relationship |
|----------|-------------|
| Git Workflow | CHANGELOG entries align with commit types (feat→Added, fix→Fixed) |
| Documentation Standards | These files follow markdown conventions and location rules |
| Document Format Standards | Markdown format per ADR-003 (model-consumed documents) |
| Testing Standards | FEATURE-INVENTORY tracks test coverage status if applicable |
