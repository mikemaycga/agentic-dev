# Agent Architecture

## Orchestrator-Worker Pattern

The environment implements Anthropic's Orchestrator-Worker pattern with Larry as the central orchestrator delegating to 11 specialist agents.

```mermaid
sequenceDiagram
    participant H as Human
    participant L as Larry (Opus)
    participant A as Architect (Opus)
    participant S as Sentinel (Sonnet)
    participant D as Developer (Sonnet)
    participant Q as QA Lead (Sonnet)
    participant DP as Deployer (Sonnet)

    H->>L: Task request
    L->>A: Design review
    A-->>L: Architecture approved
    L->>D: Implementation
    D-->>L: Code complete
    L->>Q: Quality review
    Q-->>L: Tests pass, coverage OK
    L->>S: Security review
    S-->>L: PASS (no findings)
    L->>H: Ready for deploy approval
    H->>L: Approved
    L->>DP: Deploy
    DP-->>L: Deployed, verified
    L-->>H: Task complete
```

## Agent Roster

| Agent | Model | Role | Memory |
|-------|-------|------|--------|
| **larry** | Opus | Orchestrator — task decomposition, delegation, synthesis | User |
| **architect** | Opus | Architecture design, ADRs, technical evaluation | Project |
| **sentinel** | Sonnet | Security scanning, compliance, RSP enforcement | Project |
| **qa-lead** | Sonnet | Testing strategy, quality gates, coverage | Project |
| **deployer** | Sonnet | Build, deploy, CI/CD management | Project |
| **doc-writer** | Sonnet | Documentation, help content, visual aids | Project |
| **analyst** | Opus | Contrarian analysis of external knowledge | User |
| **guide** | Sonnet | Help agent for framework questions | Project |
| **typescript-dev** | Sonnet | TypeScript/JavaScript specialist | Project |
| **python-dev** | Sonnet | Python/AI/ML specialist | Project |
| **swift-dev** | Sonnet | Swift/iOS/macOS specialist | Project |
| **react-dev** | Sonnet | React/frontend specialist | Project |

## Delegation Rules

```mermaid
flowchart TD
    T[New Task] --> L{Larry Evaluates}

    L -->|Architecture decision| A[Architect]
    L -->|Security concern| S[Sentinel]
    L -->|Implementation| SP[Specialist Agent]
    L -->|Testing needed| Q[QA Lead]
    L -->|Deploy request| D[Deployer]
    L -->|Documentation| DW[Doc Writer]
    L -->|External content| CA[Contrarian Analyst]
    L -->|Budget/client/judgment| H[Escalate to Human]

    SP --> TS[TypeScript Dev]
    SP --> PY[Python Dev]
    SP --> SW[Swift Dev]
    SP --> RE[React Dev]

    Q -->|After QA pass| S
    S -->|After security pass| D
    D -->|Production| H2[Human Approval Required]
```

## Cost Strategy

Opus is used for high-judgment tasks (orchestration, architecture, analysis). Sonnet is used for execution tasks (implementation, testing, deployment, documentation). This balances quality with cost — Anthropic's multi-agent research found systems use approximately 15x more tokens than single-agent interactions.
