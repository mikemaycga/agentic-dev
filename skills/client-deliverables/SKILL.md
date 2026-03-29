---
name: client-deliverables
description: |
  Creates and manages professional client deliverables including proposals, assessments, presentations, and reports. Triggers on: client deliverable, proposal, assessment, client report, executive summary, engagement deliverable. Does not trigger for: internal documentation (use doc-writer), code artifacts, personal notes. Produces polished, professional documents suitable for C-Suite presentation.
---

## Self-Improving Skill — Pilot

This skill participates in the self-improving skills governance framework (Option A: fully manual).

- **learnings.md**: Active learnings that inform deliverable creation (≤50 lines)
- **learnings-staging.md**: Proposed learnings awaiting human review during weekly Friday pruning

### Adding a Learning

After each client deliverable, if a pattern, preference, or feedback would improve future deliverables, append it to `learnings-staging.md` in this format:

```
- [YYYY-MM-DD] [pattern/insight] — [context where it applies]
```

Do NOT modify `learnings.md` directly. All promotions happen during weekly pruning.

---

## Workflow

1. **Understand the audience** — C-Suite executives. Every deliverable must be executive-readable.
2. **Apply professional standards:**
   - Clear structure with executive summary
   - Data-driven recommendations (no opinions without evidence)
   - Visual aids where they add clarity
   - Professional formatting (use docx/pptx skills as appropriate)
3. **Security check:**
   - No internal framework details in client-facing documents
   - No credentials, internal URLs, or proprietary information
   - Verify client-confidential content is not in iCloud-synced locations
4. **Review cycle:**
   - Self-review for accuracy and completeness
   - Flag any claims that need human verification
5. **Deliver** to appropriate location (Git repo or local storage for confidential work).

## Constraints

- Client deliverables must be professional enough for C-Suite presentation.
- Never include internal framework or agent architecture details in client documents.
- Always verify data accuracy — zero tolerance for hallucination in client work.
