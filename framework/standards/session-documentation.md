# Session Documentation Standard

**Version:** 1.0
**Date:** March 29, 2026
**Status:** Active Standard

## Purpose

Git history captures raw commits but is not scannable for "what does this project look like today" or "what changed in this session." Every development session must produce structured documentation of changes, decisions, and current state. This is a mandatory workflow step, not optional.

## Session Changelog

At the end of every development session, Larry invokes the Doc Writer agent to produce a session changelog entry. This happens before the final sync/commit.

### Format

```markdown
# Session: YYYY-MM-DD

## Summary
[1-2 sentence description of what the session accomplished]

## Changes

| Change | Files | Status |
|--------|-------|--------|
| [Description of change] | [Files modified/created] | Shipped / In Progress / Reverted |

## Decisions Made

| Decision | Rationale | ADR |
|----------|-----------|-----|
| [What was decided] | [Why] | [ADR-NNN if applicable] |

## Backlog Updates
- [Items added, reprioritized, or completed]

## Known Issues
- [Any issues introduced or discovered]

## Next Session
- [What to pick up next]
```

### Location

Session changelogs are appended to `CHANGELOG.md` in the project root. Newest entries at the top.

## Feature Inventory

Every project maintains a `FEATURES.md` in the project root — a living document mapping planned features to implementation status. This answers "what does this project do today?"

### Format

```markdown
# Feature Inventory

**Last Updated:** YYYY-MM-DD

## Implemented

| Feature | Description | Date Shipped | Files |
|---------|-------------|-------------|-------|
| [Feature name] | [What it does] | [Date] | [Key files] |

## In Progress

| Feature | Description | Target | Blockers |
|---------|-------------|--------|----------|
| [Feature name] | [What it does] | [Target date] | [Any blockers] |

## Planned

| Feature | Description | Priority | Dependencies |
|---------|-------------|----------|--------------|
| [Feature name] | [What it does] | [High/Medium/Low] | [What it depends on] |
```

### Update Rules

- Doc Writer updates FEATURES.md when features ship, start, or are added to the plan
- Every feature in "Implemented" must have the date it shipped and key files
- Features move from Planned → In Progress → Implemented as work progresses
- Removed/abandoned features are deleted with a note in the session changelog

## Larry's Responsibility

Session documentation is a mandatory final step in Larry's workflow. Before the final sync/commit:

1. Larry invokes Doc Writer with the session's git diff and commit history
2. Doc Writer produces the session changelog entry
3. Doc Writer updates FEATURES.md if features shipped or changed status
4. Larry reviews for accuracy, then includes in the final commit

This is not a recommendation. Larry must not close a session without producing documentation.

## Framework-Level Documentation

For changes to the framework itself (not project-specific), session changelogs go to `framework/evolution/CHANGELOG.md` and the feature inventory is the `framework/BACKLOG.md`.
