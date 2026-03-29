# Document Format Standards

**Version:** 1.0
**Date:** March 28, 2026
**Status:** Active Standard
**ADR Reference:** ADR-003-document-formats

---

## Governing Principle

Anthropic's #1 performance constraint is context window consumption. Every file loaded into Claude's context costs tokens. The format choice for each document type is driven by one question: **Is this file consumed by the model (context-loaded) or by the application (programmatically parsed)?**

| Consumer | Preferred Format | Reason |
|----------|-----------------|--------|
| Model (context-loaded) | Markdown + YAML frontmatter | Token-efficient; model parses natively; Anthropic's documented format |
| Application (programmatic) | JSON | Strict schema validation; machine-parseable; Anthropic's documented format |
| Both (hybrid) | Markdown + YAML frontmatter, with companion JSON where needed | Model reads markdown; tooling reads JSON |

**Anthropic Alignment:** This split matches Anthropic's own implementation. Agent `.md` files, SKILL.md, CLAUDE.md, and rules use markdown. Settings, hooks, and MCP configs use JSON. Deviating from this split means fighting the tool rather than leveraging it.

---

## Format Assignment by Document Type

### Category 1: Markdown + YAML Frontmatter (Context-Loaded by Model)

These files are read by Claude at session start or on demand. Markdown is mandatory per Anthropic's tool design.

| Document Type | Location | Format | Anthropic Requirement |
|---------------|----------|--------|-----------------------|
| CLAUDE.md | Project root or `.claude/` | Markdown | **Mandatory** — Claude Code only reads `.md` |
| Agent definitions | `.claude/agents/*.md` | Markdown + YAML frontmatter | **Mandatory** — Anthropic's subagent format |
| Skills | `.claude/skills/*/SKILL.md` | Markdown + YAML frontmatter | **Mandatory** — Anthropic's skill format |
| Rules | `.claude/rules/*.md` | Markdown + optional YAML `paths:` | **Mandatory** — Anthropic's rules format |
| Architecture docs | `framework/architecture/*.md` | Markdown | Convention (human + model readable) |
| Standards docs | `framework/standards/*.md` | Markdown | Convention (imported via `@` into CLAUDE.md) |
| Knowledge library | `knowledge-library/**/*.md` | Markdown | Convention (model-searchable) |
| ADRs | `framework/architecture/decisions/*.md` | Markdown | Convention |

**Do NOT convert these to JSON.** Claude Code will not discover or load them if they are not in the documented markdown format.

### Category 2: JSON (Programmatically Parsed by Application)

These files are read by the Claude Code application, CI/CD tools, or custom scripts. JSON provides schema validation and strict structure.

| Document Type | Location | Format | Anthropic Requirement |
|---------------|----------|--------|-----------------------|
| Project settings | `.claude/settings.json` | JSON | **Mandatory** |
| Local settings | `.claude/settings.local.json` | JSON | **Mandatory** |
| Hooks config | `.claude/hooks/hooks.json` | JSON | **Mandatory** |
| MCP server config | `.mcp.json` | JSON | **Mandatory** |
| Package manifests | `package.json`, `pyproject.toml` | JSON/TOML | Language standard |
| CI/CD workflows | `.github/workflows/*.yml` | YAML | GitHub standard |
| Security profiles | `security/profiles/*.json` | JSON | **Framework convention** — see schema below |
| Project registry | `framework/project-registry.json` | JSON | **Framework convention** — see schema below |
| Migration tracker | `framework/migration-tracker.json` | JSON | **Framework convention** — see schema below |
| Knowledge index | `knowledge-library/index.json` | JSON | **Framework convention** — see schema below |
| Assessment metadata | `knowledge-library/assessments/*.json` | JSON | **Framework convention** — see schema below |

### Category 3: Hybrid (Both Model and Application)

Some documents benefit from a markdown file (for model consumption) paired with a companion JSON file (for tooling/validation).

| Document Type | Markdown File | JSON Companion | Purpose |
|---------------|---------------|----------------|---------|
| Agent definitions | `agent-name.md` | — | Anthropic format is self-contained (YAML frontmatter + markdown body) |
| Security profiles | `profile-name.md` (human/model readable) | `profile-name.json` (machine-enforceable rules) | Model reads context; hooks/scripts enforce rules |
| Quality gates | `qa-standards.md` (readable) | `qa-gates.json` (CI/CD checkable) | Model understands intent; pipeline enforces thresholds |

---

## JSON Schemas

### Schema 1: Project Settings (`.claude/settings.json`)

Anthropic-defined. Documented here for reference.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "claude-project-settings",
  "type": "object",
  "properties": {
    "permissions": {
      "type": "object",
      "properties": {
        "allow": { "type": "array", "items": { "type": "string" } },
        "deny": { "type": "array", "items": { "type": "string" } }
      }
    },
    "autoMemoryEnabled": { "type": "boolean", "default": true },
    "claudeMdExcludes": { "type": "array", "items": { "type": "string" } },
    "hooks": { "$ref": "#/$defs/hooksConfig" },
    "agent": { "type": "string", "description": "Default agent for all sessions" }
  }
}
```

### Schema 2: Security Profile (`security/profiles/*.json`)

Framework-defined. Enforced by Sentinel agent and pre-commit hooks.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "security-profile",
  "type": "object",
  "required": ["name", "level", "rules"],
  "properties": {
    "name": {
      "type": "string",
      "description": "Profile identifier",
      "enum": ["professional-standard", "enterprise-soc2", "maximum"]
    },
    "level": {
      "type": "string",
      "enum": ["standard", "elevated", "maximum"]
    },
    "description": {
      "type": "string",
      "description": "Human-readable description of this security posture"
    },
    "rules": {
      "type": "object",
      "properties": {
        "secrets_scanning": {
          "type": "object",
          "properties": {
            "enabled": { "type": "boolean", "default": true },
            "block_commit": { "type": "boolean", "default": true },
            "patterns": {
              "type": "array",
              "items": { "type": "string" },
              "description": "Regex patterns to detect secrets"
            }
          }
        },
        "dependency_audit": {
          "type": "object",
          "properties": {
            "enabled": { "type": "boolean", "default": true },
            "max_severity": {
              "type": "string",
              "enum": ["critical", "high", "medium", "low"],
              "description": "Block if vulnerability exceeds this severity"
            },
            "audit_on_install": { "type": "boolean", "default": true }
          }
        },
        "code_review": {
          "type": "object",
          "properties": {
            "owasp_top10": { "type": "boolean", "default": true },
            "injection_detection": { "type": "boolean", "default": true },
            "auth_review": { "type": "boolean", "default": true },
            "data_handling": { "type": "boolean", "default": true }
          }
        },
        "infrastructure": {
          "type": "object",
          "properties": {
            "https_required": { "type": "boolean", "default": true },
            "env_var_validation": { "type": "boolean", "default": true },
            "container_scanning": { "type": "boolean", "default": false },
            "network_exposure_check": { "type": "boolean", "default": false }
          }
        },
        "compliance": {
          "type": "object",
          "properties": {
            "audit_trail": { "type": "boolean", "default": false },
            "rbac_verification": { "type": "boolean", "default": false },
            "encryption_at_rest": { "type": "boolean", "default": false },
            "change_management": { "type": "boolean", "default": false }
          }
        }
      }
    }
  }
}
```

### Schema 3: Project Registry (`framework/project-registry.json`)

Framework-defined. Tracks all managed projects across machines.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "project-registry",
  "type": "object",
  "required": ["version", "projects"],
  "properties": {
    "version": { "type": "string" },
    "lastUpdated": { "type": "string", "format": "date-time" },
    "projects": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id", "name", "type", "status", "repo"],
        "properties": {
          "id": { "type": "string", "description": "Unique project identifier" },
          "name": { "type": "string" },
          "type": {
            "type": "string",
            "enum": ["fullstack-web", "ios-app", "macos-app", "ai-ml", "android-app", "library", "infrastructure", "research"]
          },
          "status": {
            "type": "string",
            "enum": ["active", "maintenance", "archived", "planning"]
          },
          "repo": {
            "type": "object",
            "properties": {
              "url": { "type": "string", "format": "uri" },
              "defaultBranch": { "type": "string", "default": "main" },
              "provider": { "type": "string", "enum": ["github"] }
            }
          },
          "securityProfile": {
            "type": "string",
            "enum": ["professional-standard", "enterprise-soc2", "maximum"],
            "default": "professional-standard"
          },
          "techStack": {
            "type": "array",
            "items": { "type": "string" },
            "description": "Languages, frameworks, and key dependencies"
          },
          "agents": {
            "type": "array",
            "items": { "type": "string" },
            "description": "Agent names active for this project (beyond global defaults)"
          },
          "migrationStatus": {
            "type": "string",
            "enum": ["not-started", "in-progress", "completed", "not-applicable"]
          },
          "notes": { "type": "string" }
        }
      }
    }
  }
}
```

### Schema 4: Knowledge Library Index (`knowledge-library/index.json`)

Framework-defined. Searchable by the Help Guide and Contrarian Analyst agents.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "knowledge-library-index",
  "type": "object",
  "required": ["version", "entries"],
  "properties": {
    "version": { "type": "string" },
    "lastUpdated": { "type": "string", "format": "date-time" },
    "entries": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id", "title", "type", "status", "dateAdded"],
        "properties": {
          "id": { "type": "string" },
          "title": { "type": "string" },
          "type": {
            "type": "string",
            "enum": ["article", "video", "blog", "podcast", "whitepaper", "documentation"]
          },
          "source": {
            "type": "object",
            "properties": {
              "url": { "type": "string", "format": "uri" },
              "author": { "type": "string" },
              "publication": { "type": "string" },
              "datePublished": { "type": "string", "format": "date" }
            }
          },
          "dateAdded": { "type": "string", "format": "date" },
          "status": {
            "type": "string",
            "enum": ["inbox", "under-review", "adopted", "archived", "monitoring", "rejected"]
          },
          "assessment": {
            "type": "object",
            "properties": {
              "assessmentFile": { "type": "string", "description": "Path to assessment markdown" },
              "recommendation": {
                "type": "string",
                "enum": ["adopt", "consider", "archive", "reject"]
              },
              "novelClaims": { "type": "integer", "minimum": 0 },
              "knownClaims": { "type": "integer", "minimum": 0 },
              "conflictClaims": { "type": "integer", "minimum": 0 },
              "humanDecision": {
                "type": "string",
                "enum": ["pending", "adopted", "rejected", "deferred"],
                "default": "pending"
              },
              "humanNotes": { "type": "string" }
            }
          },
          "tags": {
            "type": "array",
            "items": { "type": "string" }
          },
          "relatedStandards": {
            "type": "array",
            "items": { "type": "string" },
            "description": "Paths to framework standards this content relates to"
          },
          "filePath": {
            "type": "string",
            "description": "Path to the content markdown file"
          }
        }
      }
    }
  }
}
```

### Schema 5: Knowledge Assessment Metadata (`knowledge-library/assessments/*.json`)

Companion to the markdown assessment file. Structured data for querying and reporting.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "knowledge-assessment",
  "type": "object",
  "required": ["assessmentId", "contentId", "dateAssessed", "claims", "recommendation"],
  "properties": {
    "assessmentId": { "type": "string" },
    "contentId": { "type": "string", "description": "References knowledge-library index entry" },
    "dateAssessed": { "type": "string", "format": "date" },
    "assessedBy": { "type": "string", "default": "contrarian-analyst" },
    "claims": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["claim", "status", "contrarianView"],
        "properties": {
          "claim": { "type": "string" },
          "status": {
            "type": "string",
            "enum": ["novel", "known", "conflict"]
          },
          "contrarianView": { "type": "string" },
          "evidence": { "type": "string" },
          "recommendation": {
            "type": "string",
            "enum": ["adopt", "consider", "archive", "reject"]
          },
          "relatedStandard": {
            "type": "string",
            "description": "Path to the framework standard this claim relates to"
          }
        }
      }
    },
    "recommendation": {
      "type": "string",
      "enum": ["adopt", "consider", "archive", "reject"]
    },
    "summary": { "type": "string", "maxLength": 500 },
    "humanDecision": {
      "type": "object",
      "properties": {
        "decision": {
          "type": "string",
          "enum": ["pending", "adopted", "rejected", "deferred"]
        },
        "date": { "type": "string", "format": "date" },
        "notes": { "type": "string" }
      }
    }
  }
}
```

### Schema 6: Migration Tracker (`framework/migration-tracker.json`)

Tracks migration of existing projects into the framework.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "migration-tracker",
  "type": "object",
  "required": ["version", "migrations"],
  "properties": {
    "version": { "type": "string" },
    "lastUpdated": { "type": "string", "format": "date-time" },
    "migrations": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["projectId", "status"],
        "properties": {
          "projectId": { "type": "string", "description": "References project-registry" },
          "status": {
            "type": "string",
            "enum": ["not-started", "assessed", "in-progress", "completed", "blocked"]
          },
          "steps": {
            "type": "object",
            "properties": {
              "claudeMdCreated": { "type": "boolean", "default": false },
              "dotClaudeSetup": { "type": "boolean", "default": false },
              "agentsConfigured": { "type": "boolean", "default": false },
              "skillsConfigured": { "type": "boolean", "default": false },
              "hooksConfigured": { "type": "boolean", "default": false },
              "securityScanCompleted": { "type": "boolean", "default": false },
              "validationPassed": { "type": "boolean", "default": false }
            }
          },
          "dateStarted": { "type": "string", "format": "date" },
          "dateCompleted": { "type": "string", "format": "date" },
          "blockers": {
            "type": "array",
            "items": { "type": "string" }
          },
          "notes": { "type": "string" }
        }
      }
    }
  }
}
```

### Schema 7: Quality Gates (`framework/standards/qa-gates.json`)

Machine-enforceable quality thresholds used by QA Lead agent and CI/CD.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "quality-gates",
  "type": "object",
  "required": ["version", "gates"],
  "properties": {
    "version": { "type": "string" },
    "gates": {
      "type": "object",
      "properties": {
        "testing": {
          "type": "object",
          "properties": {
            "minimumCoverage": { "type": "number", "minimum": 0, "maximum": 100, "default": 80 },
            "unitTestsRequired": { "type": "boolean", "default": true },
            "integrationTestsRequired": { "type": "boolean", "default": true },
            "e2eTestsRequired": { "type": "boolean", "default": false },
            "allTestsMustPass": { "type": "boolean", "default": true }
          }
        },
        "codeQuality": {
          "type": "object",
          "properties": {
            "lintMustPass": { "type": "boolean", "default": true },
            "typeCheckMustPass": { "type": "boolean", "default": true },
            "maxCyclomaticComplexity": { "type": "integer", "default": 15 },
            "noTodoInCode": { "type": "boolean", "default": false }
          }
        },
        "performance": {
          "type": "object",
          "properties": {
            "noRegressionAllowed": { "type": "boolean", "default": true },
            "benchmarkRequired": { "type": "boolean", "default": false },
            "maxBundleSizeKb": { "type": "integer" }
          }
        },
        "security": {
          "type": "object",
          "properties": {
            "sentinelReviewRequired": { "type": "boolean", "default": true },
            "noKnownVulnerabilities": { "type": "boolean", "default": true },
            "secretsScanPassed": { "type": "boolean", "default": true }
          }
        },
        "documentation": {
          "type": "object",
          "properties": {
            "readmeRequired": { "type": "boolean", "default": true },
            "apiDocsRequired": { "type": "boolean", "default": false },
            "changelogUpdated": { "type": "boolean", "default": true }
          }
        }
      }
    },
    "overrides": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "projectId": { "type": "string" },
          "gate": { "type": "string" },
          "value": {},
          "reason": { "type": "string" }
        }
      },
      "description": "Per-project overrides with documented justification"
    }
  }
}
```

---

## Summary: Format Decision Matrix

| Document | Format | Loaded By | Reason |
|----------|--------|-----------|--------|
| CLAUDE.md | Markdown | Model (mandatory) | Anthropic requirement |
| Agent definitions | MD + YAML | Model (mandatory) | Anthropic requirement |
| Skills | MD + YAML | Model (mandatory) | Anthropic requirement |
| Rules | MD + YAML | Model (mandatory) | Anthropic requirement |
| Architecture docs | Markdown | Model (via `@` import) | Token-efficient for context |
| Standards docs | Markdown | Model (via `@` import) | Token-efficient for context |
| Knowledge articles | Markdown | Model (via agent search) | Token-efficient for context |
| Assessments | MD + JSON companion | Model reads MD; tooling reads JSON | Hybrid: human analysis + structured data |
| Settings | JSON | Application (mandatory) | Anthropic requirement |
| Hooks | JSON | Application (mandatory) | Anthropic requirement |
| MCP config | JSON | Application (mandatory) | Anthropic requirement |
| Security profiles | JSON (+ optional MD) | Application + hooks | Machine-enforceable rules |
| Project registry | JSON | Application + scripts | Structured data, queryable |
| Migration tracker | JSON | Application + scripts | Structured data, queryable |
| Quality gates | JSON | CI/CD + QA agent | Machine-enforceable thresholds |
| Knowledge index | JSON | Agents + scripts | Searchable structured index |

---

*This standard is enforced by convention and documented in the framework CLAUDE.md. Agents should reference this document when creating new files to determine the correct format.*
