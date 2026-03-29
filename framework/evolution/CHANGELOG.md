# Framework Changelog

## [1.0.0] - 2026-03-28

### Added
- Initial framework structure created from architecture document v1.6
- Global CLAUDE.md with user-level instructions
- 8 core agent definitions: Larry (orchestrator), Architect, Sentinel, QA Lead, Deployer, Doc Writer, Contrarian Analyst, Help Guide
- 4 specialist agents: TypeScript, Python, Swift, React
- 6 skill scaffolds: fix-issue, review-pr, deploy, security-scan, architecture-review (pilot), client-deliverables (pilot)
- Self-improving skills governance on pilot skills (architecture-review, client-deliverables)
- 3 security profiles: professional-standard, enterprise-soc2, maximum
- 6 framework standards: code-style, security-baseline, testing, git-workflow, documentation, QA gates
- 3 project templates: fullstack-web, ios-app, ai-ml-pipeline
- Knowledge library structure with README
- Setup script for cross-machine deployment
- Cross-machine setup instructions document

### Architecture Decisions
- ADR-001: Git as primary sync (iCloud secondary for non-Git content)
- ADR-002: Orchestrator-Worker agent architecture
- ADR-003: Markdown for model-consumed files, JSON for app-parsed files
- ADR-004: Skill-building standards (200-line target, 500-line max)
