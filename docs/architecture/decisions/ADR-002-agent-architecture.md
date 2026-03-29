# ADR-002: Multi-Agent Architecture

**Status:** Accepted
**Date:** 2026-03-28

## Context

Complex development tasks require multiple specialized capabilities (architecture, security, testing, deployment, documentation). A single monolithic agent would exceed context limits and lack specialization. Anthropic's documentation validates several multi-agent patterns.

## Decision

Adopt the Orchestrator-Worker pattern with Larry as the central orchestrator delegating to specialist agents. Flat delegation only — subagents cannot spawn other subagents (per Anthropic's documented constraint).

## Consequences

- Larry (Opus) handles task decomposition, delegation, and synthesis
- Specialists (mostly Sonnet) handle domain-specific implementation
- All delegation is direct from Larry to workers — no chaining through intermediaries
- Cost is managed by using Opus only for orchestration and high-judgment tasks

## Alternatives Considered

- **Prompt chaining:** Too rigid for dynamic task decomposition
- **Routing pattern:** Insufficient for complex multi-step tasks
- **Flat specialists without orchestrator:** No coordination, duplication risk
