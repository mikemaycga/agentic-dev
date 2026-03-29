# Specialist Agents

All specialist agents run on Sonnet (except the Contrarian Analyst, which uses Opus) and use project-level memory. They receive bounded tasks from Larry and report back with results.

## Development Specialists

### TypeScript Dev

**Model:** Sonnet | **Scope:** TypeScript/JavaScript, Node.js, React, Next.js, Express

Standards enforced: strict TypeScript, ESLint, Prettier formatting, explicit return types on exports, `const` over `let`, `var` prohibited. Reads project CLAUDE.md and `.claude/rules/` before implementation.

### Python Dev

**Model:** Sonnet | **Scope:** Python, Django, FastAPI, Flask, PyTorch, AI/ML pipelines

Standards enforced: Python 3.11+, type hints on all signatures, Ruff for linting/formatting, Google-style docstrings, pytest for testing, virtual environments required.

### Swift Dev

**Model:** Sonnet | **Scope:** Swift, SwiftUI, UIKit, Combine, Swift Package Manager

Standards enforced: Swift 5.9+ with strict concurrency checking, SwiftUI preferred for new views, XCTest for testing, Apple Human Interface Guidelines compliance.

### React Dev

**Model:** Sonnet | **Scope:** React, Next.js, component architecture, state management

Standards enforced: functional components with hooks (no class components), TypeScript required, composition over prop drilling, React Testing Library, WCAG 2.1 AA accessibility minimum.

## Support Specialists

### QA Lead

**Model:** Sonnet | **Role:** Testing strategy, quality gates, coverage enforcement

Enforces quality gates defined in `qa-gates.json`: 80% line coverage, zero lint errors, all tests passing, security scan pass. Reviews test strategy and validates coverage before deployment approval.

### Deployer

**Model:** Sonnet | **Role:** Build, deploy, CI/CD management

Manages deployment workflows with mandatory pre-flight checks: QA sign-off, Sentinel review, human approval for production. Includes RSP-specific checks for AI-powered features (threat model, risk-benefit, audit trail).

### Doc Writer

**Model:** Sonnet | **Role:** Documentation, help content, visual aids

Creates and maintains documentation following the [Documentation Standards](../standards/documentation.md). Produces scenario-based help, visual aids (Mermaid diagrams, mindmaps), and structured reference content.

### Contrarian Analyst

**Model:** Opus | **Memory:** User | **Role:** External knowledge assessment

Evaluates external articles, research, and vendor claims using a structured assessment process. Archives content to the knowledge library with claim-by-claim analysis, confidence ratings, and actionable recommendations. Designed to counter confirmation bias in technology adoption decisions.

### Guide

**Model:** Sonnet | **Role:** Help agent for framework questions

Read-only agent that answers questions about the framework, its standards, agent capabilities, and skill catalog. Does not modify files or execute code — purely informational.

## Common Workflow

All specialist agents follow the same protocol:

1. Read project CLAUDE.md for project-specific conventions
2. Read relevant `.claude/rules/` files
3. Understand existing patterns before introducing new ones
4. Execute the assigned task
5. Report back to Larry: files changed, tests written, any concerns
