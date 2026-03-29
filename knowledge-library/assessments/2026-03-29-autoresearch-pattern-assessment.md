# AutoResearch Pattern Assessment

**Date:** 2026-03-29
**Analyst:** Contrarian Analyst
**Source:** Andrej Karpathy (GitHub: karpathy/autoresearch), community extensions
**Status:** Assessed — Medium Priority Tool

## Summary

AutoResearch is an autonomous experiment loop created by Andrej Karpathy (released March 7, 2026, MIT license, 21,000+ GitHub stars). A 630-line Python script that lets an AI agent autonomously design, run, and evaluate experiments against a measurable metric. Originally built for ML training optimization, the pattern has been generalized by the community to any domain with measurable outcomes.

## How It Works

1. Human writes `program.md` defining research direction and constraints
2. AI agent modifies a target file (the controllable variable)
3. Agent runs a time-boxed experiment (default: 5 minutes)
4. Agent evaluates result against a defined metric
5. Agent keeps or discards changes based on improvement
6. Loop repeats (~12 experiments/hour, ~100 overnight)

### Architecture (3 files)

| Component | Role | Agent Access |
|-----------|------|--------------|
| `program.md` | Research direction and constraints (human-authored) | Read only |
| Target file (e.g., `train.py`) | The variable the agent optimizes | Read/Write |
| Infrastructure (e.g., `prepare.py`) | Fixed utilities and data prep | Read only |

### Key Results (Karpathy's original run)

- ~700 experiments over 2 days, ~20 real improvements
- GPT-2 training time: 2.02 → 1.80 hours (11% faster)
- Shopify CEO trained a 0.8B model overnight that outperformed his previous 1.6B model

## Claim-by-Claim Assessment

| # | Claim | Verdict | Confidence | Notes |
|---|-------|---------|------------|-------|
| 1 | Autonomous overnight optimization is production-viable | **Validated** | High | Multiple independent reproductions; MIT-licensed; minimal dependencies |
| 2 | Pattern generalizes beyond ML training | **Validated** | Medium-High | Community projects (pi-autoresearch, autoresearch-anything) demonstrate SQL, API, prompt, build optimization |
| 3 | ~100 experiments per night on single GPU | **Validated** | High | Karpathy's original results + community reproductions |
| 4 | Produces reliably better outcomes than manual tuning | **Partially validated** | Medium | Works for gradient optimization problems; not validated for discrete/architectural choices |
| 5 | `program.md` pattern is sufficient for agent guidance | **Validated** | High | Analogous to our SKILL.md pattern; proven across multiple agent implementations |
| 6 | Works with Claude Code as the agent | **Validated** | High | Karpathy's documentation explicitly supports Claude Code |
| 7 | Safe for unattended operation | **Conditional** | Medium | Requires scoped file access, time-boxing, and git-based rollback. No inherent safety controls |
| 8 | Applicable to business rule optimization | **Not validated** | Low | Business rules require correctness, not gradient optimization. Pattern does not fit |

## Framework Integration Decision

**Adopted as:** Medium-priority framework tool for specific business projects

**Role:** A specialized execution strategy that Larry delegates to when a task matches the pattern (measurable outcome + controllable variable + repeatable evaluation). Not a replacement for the orchestrator-worker model.

### Applicable Use Cases

| Use Case | Metric | Variable |
|----------|--------|----------|
| Prompt optimization | Quality score, latency | System prompts, few-shot examples |
| Build/CI tuning | Build time, test duration | Configuration, parallelization |
| API performance | Latency (p50/p95/p99) | Query patterns, caching, pooling |
| Database query optimization | Execution time | Indexes, query structure |
| Bundle size reduction | Bundle size (KB) | Import strategies, splitting config |
| Model selection/tuning | Quality vs cost vs latency | Model, temperature, prompt |

### Not Applicable

- Business rule implementation (correctness, not optimization)
- Architecture decisions (judgment, not measurable iteration)
- Security review (binary pass/fail)
- Client deliverables (subjective quality)

### Governance Requirements

- Sentinel reviews scope of modifiable files before loop starts
- QA Lead validates evaluation metric is sound
- Git history serves as audit trail (each experiment = commit)
- Time-box and iteration cap enforced
- Human reviews final results before production adoption

## Sources

- [karpathy/autoresearch — GitHub](https://github.com/karpathy/autoresearch)
- [Guide to AutoResearch — DataCamp](https://www.datacamp.com/tutorial/guide-to-autoresearch)
- [VentureBeat coverage](https://venturebeat.com/technology/andrej-karpathys-new-open-source-autoresearch-lets-you-run-hundreds-of-ai)
- [AutoResearch Non-ML Applications — BSWEN](https://docs.bswen.com/blog/2026-03-29-autoresearch-non-ml/)
- [pi-autoresearch — Ry Walker](https://rywalker.com/research/pi-autoresearch)
- [AutoResearch for Business Optimization — MindStudio](https://www.mindstudio.ai/blog/what-is-autoresearch-loop-karpathy-business-optimization)
- [AutoResearch: Blueprint for Self-Improving Agents — Mager](https://www.mager.co/blog/2026-03-14-autoresearch-pattern/)
