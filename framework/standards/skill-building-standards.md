# Skill-Building Standards

**Version:** 1.0
**Date:** March 28, 2026
**Status:** Active Standard
**ADR Reference:** ADR-004-skill-building
**Anthropic Source:** [Skill Authoring Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

---

## Governing Principle

Anthropic's #1 constraint — context window as a public good — applies directly to skill design. Every token in a skill competes with conversation history, other skills, and the user's actual request. Skills must be concise, well-structured, and tested. The default assumption is that Claude is already very intelligent; skills should only provide context Claude does not already have.

**Anthropic Alignment:** "Challenge each piece of information: Does Claude really need this explanation? Can I assume Claude knows this? Does this paragraph justify its token cost?" — Anthropic Best Practices

---

## 1. SKILL.md Size Constraints

| Threshold | Value | Source |
|-----------|-------|--------|
| **Target maximum** | 200 lines | Practical efficiency ceiling (validated by @simonscrapes production testing with 20+ skills) |
| **Hard maximum** | 500 lines | Anthropic official: "Keep SKILL.md body under 500 lines for optimal performance" |
| **Reference files** | 200–300 lines each | Practical limit per reference file to maintain focused context loading |

Skills exceeding 200 lines should be evaluated for progressive disclosure opportunities. Skills exceeding 500 lines must be refactored before deployment.

**Rationale:** The 200-line target enforces discipline around progressive disclosure. SKILL.md functions as a table of contents that tells Claude where to look for detailed information. Detailed documentation belongs in reference files loaded on demand. The 500-line hard maximum is Anthropic's documented performance boundary.

---

## 2. Progressive Disclosure (Three-Tier Architecture)

Anthropic's progressive disclosure architecture determines when information enters Claude's context window:

| Tier | Content | When Loaded | Size Guidance |
|------|---------|-------------|---------------|
| **Tier 1** | YAML frontmatter (`name` + `description`) | Always loaded at session start for all installed skills | `name`: ≤64 characters, lowercase/numbers/hyphens only. `description`: ≤1,024 characters. |
| **Tier 2** | SKILL.md body (instructions, workflow steps) | Loaded only when skill is activated by Claude | Target ≤200 lines, hard max 500 lines |
| **Tier 3** | Reference files, scripts, assets | Loaded only when a specific step references them | 200–300 lines per file recommended |

**Critical constraint:** Do not install excessive skills. Every skill's Tier 1 metadata occupies persistent context space. Prioritize quality over quantity.

**Reference depth:** Keep all references one level deep from SKILL.md. Anthropic warns that nested references (SKILL.md → advanced.md → details.md) cause partial reads. All reference files must link directly from SKILL.md.

**Reference file structure:** Files over 100 lines should include a table of contents at the top so Claude can see scope even during partial reads.

---

## 3. YAML Frontmatter Standards

### Name Field

- Maximum 64 characters
- Lowercase letters, numbers, and hyphens only
- Cannot contain XML tags
- Cannot contain reserved words: "anthropic", "claude"
- Use gerund form (verb + -ing) for clarity: `processing-pdfs`, `analyzing-spreadsheets`, `testing-code`

### Description Field — Three-Part Framework

Every skill description must include three components:

| Component | Purpose | Example |
|-----------|---------|---------|
| **Trigger keywords** | Words/phrases that should activate this skill | "Triggers on: research, trending topics, market research" |
| **Negative triggers** | Words/phrases that should NOT activate this skill | "Does not trigger for: general web browsing, simple URL fetching" |
| **Outcome statement** | What the skill produces and what it does | "Produces a structured research brief analyzing trends from the last 30 days" |

**Anthropic requirements for the description field:**

- Always write in third person ("Processes Excel files" not "I can help you process")
- Be specific and include key terms
- Description is the primary signal Claude uses to select from potentially 100+ available skills
- Maximum 1,024 characters

**Example — well-structured description:**

```yaml
description: >
  Analyzes codebase architecture and generates technical design documents.
  Triggers on: architecture review, system design, tech debt assessment,
  dependency analysis. Does not trigger for: code writing, bug fixing,
  or deployment tasks. Produces structured architecture documents with
  diagrams, dependency maps, and improvement recommendations.
```

---

## 4. Skill Directory Structure

Standard skill directory layout per Anthropic's documented pattern:

```
skill-name/
├── SKILL.md              # Brain — instructions and workflow (Tier 2)
├── references/            # Detailed documentation (Tier 3)
│   ├── domain-specific.md
│   ├── examples.md
│   └── api-reference.md
├── scripts/               # Executable code (Tier 3, executed not loaded)
│   ├── validate.py
│   └── process.py
└── assets/                # Templates, fonts, icons (Tier 3)
```

**Key distinctions for scripts:**

- Scripts are executed via Bash, not loaded into context
- Only script output consumes tokens
- Make execution intent clear in SKILL.md: "Run `scripts/validate.py`" (execute) vs. "See `scripts/validate.py` for the algorithm" (read as reference)

**For skills with domain-specific reference organization:**

```
bigquery-skill/
├── SKILL.md
└── reference/
    ├── finance.md         # Revenue, billing metrics
    ├── sales.md           # Opportunities, pipeline
    └── product.md         # API usage, features
```

Claude loads only the relevant reference file based on the user's query.

---

## 5. Shared Context Pattern (Non-Code Skills)

For Cowork and business-oriented skills, a shared context folder prevents duplication of business context across multiple skills:

```
.claude/skills/
├── shared-context/              # Referenced by multiple skills
│   ├── brand-guidelines.md
│   ├── audience-personas.md
│   ├── project-architecture.md  # For dev skills: system overview
│   └── coding-standards.md      # For dev skills: conventions
├── skill-a/
│   ├── SKILL.md                 # References shared-context/ files as needed
│   └── references/
└── skill-b/
    ├── SKILL.md                 # References shared-context/ files as needed
    └── references/
```

**Constraints:**

- Shared context folder must be at a stable, conventional path
- Each SKILL.md must explicitly reference the shared files it needs (progressive disclosure — don't load all shared context automatically)
- For development projects, shared context already exists in CLAUDE.md and `.claude/rules/` — do not duplicate

**Applicability:** Primarily for Cowork/business skills. Development skills should rely on CLAUDE.md and rules for project-level context.

---

## 6. Degrees of Freedom

Match instruction specificity to task fragility (Anthropic's guidance):

| Freedom Level | When to Use | Example |
|---------------|-------------|---------|
| **High** (text-based, general instructions) | Multiple approaches are valid; decisions depend on context | Code review, content analysis |
| **Medium** (pseudocode, parameterized scripts) | A preferred pattern exists but some variation is acceptable | Report generation, data processing |
| **Low** (exact scripts, no parameters) | Operations are fragile, error-prone, or must be consistent | Database migrations, deployment scripts |

**Anthropic's analogy:** Narrow bridge with cliffs = low freedom (exact instructions). Open field = high freedom (general direction).

---

## 7. Evaluation-Driven Development

**Anthropic mandates:** "Create evaluations BEFORE writing extensive documentation."

### Process

1. **Identify gaps:** Run Claude on representative tasks without a skill. Document specific failures.
2. **Create evaluations:** Build 3+ scenarios that test these gaps.
3. **Establish baseline:** Measure Claude's performance without the skill.
4. **Write minimal instructions:** Address only documented gaps.
5. **Iterate:** Execute evaluations, compare against baseline, refine.

### Evaluation Structure (Anthropic's format)

```json
{
  "skills": ["skill-name"],
  "query": "The task to test",
  "files": ["test-files/input.pdf"],
  "expected_behavior": [
    "Successfully performs action X",
    "Produces output matching criteria Y",
    "Does not exhibit failure mode Z"
  ]
}
```

### Assertions-Based Testing

Run the skill 5 times against 3-5 specific criteria per test. Grade each run against the criteria. Report pass rates.

**Criteria selection:** Choose 3-5 measurable assertions per test run. Testing too many criteria simultaneously reduces grading accuracy.

### A/B Testing Reference Files

To validate whether a reference file improves skill quality:

1. Run the same task 5 times WITH the reference file
2. Run the same task 5 times WITHOUT the reference file
3. Grade both sets against identical criteria
4. Compare pass rates, token usage, and execution time

This validates whether each reference file justifies its token cost. Remove reference files that do not measurably improve output quality.

---

## 8. Skill-Creator Meta-Skill

Anthropic provides a built-in skill-creator skill for:

- Creating new skills from scratch
- Refactoring existing skills (reducing line count, improving progressive disclosure)
- Optimizing skill descriptions for better triggering accuracy
- Running evaluations and benchmarks
- A/B testing skill variations

**Recommended use cases:**

| Use Case | When |
|----------|------|
| **Refactor marketplace skills** | After importing any marketplace skill >200 lines |
| **Optimize descriptions** | When skill activation rate is below expectations |
| **Run evaluations** | During skill development and after significant changes |
| **Create new skills** | Starting from a task you've already completed manually |

---

## 9. Skill Development Workflow (Anthropic's Claude A / Claude B Pattern)

Anthropic recommends a two-instance development pattern:

1. **Complete a task without a skill** — work through it with Claude ("Claude A"), noting what context you repeatedly provide
2. **Identify reusable patterns** — what knowledge would help future similar tasks?
3. **Ask Claude A to create the skill** — it generates properly structured SKILL.md natively
4. **Review for conciseness** — remove anything Claude already knows
5. **Improve information architecture** — push details into reference files
6. **Test with Claude B** — fresh instance using the skill on real tasks
7. **Iterate** — bring observations from Claude B back to Claude A for refinement

**Key insight:** "Claude models understand the Skill format and structure natively. You don't need special system prompts or a 'writing skills' skill to get Claude to help create Skills." — Anthropic Best Practices

---

## 10. Common Patterns

### Template Pattern

Provide output format templates. Match strictness to requirements:

- **Strict** (API responses, data formats): "ALWAYS use this exact template structure"
- **Flexible** (analysis, reports): "Here is a sensible default, adapt as needed"

### Examples Pattern

For output-quality-dependent skills, provide input/output pairs (same principle as prompt engineering).

### Conditional Workflow Pattern

Guide Claude through decision points: "Creating new? → Follow creation workflow. Editing existing? → Follow editing workflow."

### Feedback Loop Pattern

For quality-critical operations: Run validator → fix errors → re-validate → only proceed when validation passes.

---

## 11. Anti-Patterns

| Anti-Pattern | Why It's Wrong | Fix |
|-------------|----------------|-----|
| Monolithic SKILL.md (500+ lines) | Context bloat, performance degradation | Refactor using progressive disclosure |
| Vague descriptions ("Helps with documents") | Poor activation, triggers on everything or nothing | Use three-part framework (trigger/negative/outcome) |
| Deeply nested references (3+ levels) | Claude partially reads nested files | Keep references one level deep |
| Multiple approach options without default | Confuses Claude; wastes tokens on evaluation | Provide one default with escape hatch |
| Windows-style paths (`scripts\helper.py`) | Breaks on Unix systems | Use forward slashes always |
| Assuming package availability | Runtime failures | Explicitly list and verify dependencies |
| Time-sensitive information | Becomes wrong over time | Use "current method" / "old patterns" structure |
| Magic numbers in scripts | Claude can't determine right values | Document all constants with rationale |

---

## 12. Self-Improving Skills (Adopted — Piloting)

**Status:** Adopted. Governance framework designed. Piloting with two skills.

**Decision date:** March 28, 2026
**Full governance framework:** `knowledge-library/articles/2026-03-28-self-improving-skills-governance-framework.md`

| Parameter | Value |
|-----------|-------|
| Implementation option | Option A — Fully manual |
| Pilot skills | Architecture review, Client deliverables |
| Pilot duration | 4-6 weeks |
| Learnings file cap | 50 lines maximum |
| Pruning cadence | Weekly, Fridays 4PM (scheduled task) |
| Human gate | All learnings require human approval before activation |
| Precedence | SKILL.md always overrides learnings.md |

**Key governance controls:** Human approval gate on all learnings. Staging file (`learnings-staging.md`) for proposals. Active file (`learnings.md`) for approved learnings only. Promotion pathway from learnings to permanent SKILL.md instructions. Git version control for full audit trail.

**Not an Anthropic-documented pattern.** This is a governed extension of Anthropic's auto memory model. See governance framework document for full deviation disclosure and risk analysis.

---

## 13. Deferred Patterns

| Pattern | Source | Status | Decision | Revisit When |
|---------|--------|--------|----------|--------------|
| Wrap-up skill (automated session-end capture) | @simonscrapes Level 6 | Deferred | Manual capture (Option A) chosen for foundation phase. Automated capture via SessionEnd hook is Option C. | After 4-6 week pilot proves the manual pattern works. |
| Cross-skill workflows | @simonscrapes Level 7 | Deferred | Skills remain independently functional. Multi-skill coordination is Larry's orchestration responsibility. | When Larry's delegation patterns are tested in production. |

---

## 14. Practical Constraint: Installed Skill Count

Do not install excessive skills. Every skill's Tier 1 metadata (name + description from YAML frontmatter) occupies persistent context space at session start. While Anthropic documents per-skill limits (name ≤64 chars, description ≤1,024 chars), the aggregate impact of many skills on context window efficiency is a practical concern.

**Guidance:** Regularly audit installed skills. Remove skills that are not actively used. Prioritize quality (well-structured, well-described) over quantity.

---

## Sources

- Anthropic: [Skill Authoring Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) — retrieved March 28, 2026
- Anthropic: [Skills Guide (API)](https://platform.claude.com/docs/en/build-with-claude/skills-guide) — retrieved March 28, 2026
- @simonscrapes: "Every Level of Claude Code Skills in 27 mins" — transcript assessed March 28, 2026
- Assessment: `knowledge-library/assessments/2026-03-28-simonscrapes-skill-building-levels.md`
