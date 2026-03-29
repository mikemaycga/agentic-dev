# ADR-001: Cross-Machine Sync Strategy

**Status:** Accepted
**Date:** 2026-03-28

## Context

The environment must synchronize across 3+ Apple Silicon Macs. Code, agent definitions, skills, and standards all need to be consistent across machines. Several sync options exist (Git, iCloud, Dropbox, Google Drive), each with different trade-offs around Git compatibility, security, and conflict resolution.

## Decision

Git via GitHub as primary sync for all code, framework files, agents, skills, and standards. iCloud Drive as secondary sync for non-Git content only (Cowork outputs, large media files).

## Consequences

- All version-controlled content has explicit merge resolution and full history
- `.git` directories are never placed inside iCloud-synced folders
- Client-confidential deliverables stay in Git repos or local storage (iCloud ADP is off)
- Each machine independently clones the repository; symlinks map framework to `~/.claude/`

## Alternatives Considered

- **iCloud only:** Rejected due to documented `.git` directory corruption with iCloud optimization
- **Dropbox:** Rejected due to known lock file issues and sync conflict duplication
- **Google Drive:** Rejected due to symlink issues and data mining concerns for client work
