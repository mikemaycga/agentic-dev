# Agentic Development Environment

A production-grade development environment built on Anthropic's Claude Code, designed for cross-machine synchronization across Apple Silicon Macs.

## Owner

Mike May — Fractional CIO/CTO and AI Consultant

## Architecture

This framework implements Anthropic's Orchestrator-Worker pattern with 12 specialized agents, 6 skills (including 2 self-improving pilot skills), 3 project templates, and 3 security profiles.

Full architecture documentation: `framework/architecture/AGENTIC-DEV-ENVIRONMENT-v1.md`

## Quick Start

```bash
# Primary machine (first-time setup)
./setup.sh primary

# Additional machines
gh repo clone agentic-dev ~/agentic-dev
cd ~/agentic-dev && ./setup.sh secondary
```

See `SETUP-INSTRUCTIONS.md` for detailed cross-machine setup.

## Structure

```
~/agentic-dev/
├── CLAUDE.md              # Global instructions for all Claude sessions
├── agents/                # Agent definitions (12 agents)
├── skills/                # Skill definitions (6 skills)
├── templates/             # Project templates (fullstack-web, ios-app, ai-ml-pipeline)
├── framework/             # Standards, architecture docs, ADRs
├── knowledge-library/     # Curated external knowledge
├── security/              # Security profiles and policies
└── cowork-projects/       # Non-code project workspace
```

## Standards

- ADR-001: Git primary sync, iCloud secondary
- ADR-002: Orchestrator-Worker agent architecture
- ADR-003: Markdown for models, JSON for applications
- ADR-004: Skill-building standards (200-line target, 500-line max)
