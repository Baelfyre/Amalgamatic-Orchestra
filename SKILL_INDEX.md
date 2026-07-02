# Skill Index

## Purpose
This document serves as the canonical router lookup table for the Orchestra ecosystem. It enables Conductor's router-first execution by providing a lightweight summary of all available skills, their triggers, risk profiles, and dependencies without requiring full prompt-loading of every `SKILL.md` file.

## Router Usage
Conductor must consult this index to select the appropriate specialist or execution stack when the route is ambiguous. Do not load individual specialist `SKILL.md` files unless that specialist is actively executing a task.

## Execution Modes
- **Ideation**: Brainstorming, no code edits.
- **Prototype**: Experimental local code, lightweight validation.
- **Implementation**: Standard development, fast-path governance.
- **Audit**: Read-only formal reviews, full governance.
- **Release**: Deployment or public artifacts, strict compliance gates.

## Risk Levels
- **Low**: Formatting, syntax fixes, safe UI changes.
- **Medium**: Backend logic, minor schema changes.
- **High**: Data persistence, authentication, sensitive access.
- **Extreme**: Destructive testing, production modification, PII.

## Skill Lookup Table

| Skill | Purpose | Trigger Terms | Mode | Risk | Governance | Context Dependencies |
|---|---|---|---|---|---|---|
| `the-steward` | Business alignment, scope, SDLC | "goals", "scope", "requirements", "acceptance criteria" | Audit, Release | Low | None | `docs/governance/GOVERNANCE_LAYER.md` |
| `the-governor` | Legal, compliance, privacy, IP | "legal", "privacy", "license", "compliance" | Audit, Release | Low | None | `docs/governance/GOVERNANCE_LAYER.md` |
| `arbiter` | Continuity, validation, transitions | "interrupted", "diverged", "blocked", "verify" | All | Medium | the-steward, the-governor | Git status, diffs, test outputs |
| `conductor` | Routing, workflow orchestration | "start", "plan", "coordinate", "route" | All | Medium | conditional | `ROUTING_MAP.md`, `SKILL_INDEX.md` |
| `clockwork` | OOP, layering, architecture refactors | "refactor", "layering", "service boundary" | Implementation | High | conditional | None |
| `cipher` | Security, privacy, access control | "auth", "RBAC", "secrets", "threats" | Implementation, Audit | High | conditional | `docs/governance/GOVERNANCE_LAYER.md` |
| `cloak` | UI/UX, accessibility, frontend design | "ui", "ux", "accessibility", "responsive" | Ideation, Implementation | Low | conditional | None |
| `chronicler`| Database, schema, normalization | "sql", "migration", "schema", "ORM" | Implementation, Audit | High | conditional | None |
| `overseer` | QA, test strategy, CI readiness | "qa", "tests", "validation", "smoke" | Audit, Release | Medium | conditional | None |
| `dagger` | Chaos, failure paths, resilience | "chaos", "negative tests", "resilience" | Prototype (Simulation) | Extreme | Explicit Approval | `scripts/dagger_guardrail.py` |
| `weaver` | UML, ERD, architecture diagrams | "diagram", "uml", "erd", "mermaid" | Ideation, Audit | Low | conditional | None |
| `scribe` | Documentation, READMEs, changelogs | "docs", "readme", "release notes" | All | Low | conditional | None |
| `ponytail` | Implementation, safe code edits | "implement", "fix", "code" | Implementation | Medium | conditional | None |

## Avoid-When Notes
- **the-steward**: Avoid when legal, regulatory, privacy, licensing, or IP review is needed (use `the-governor`).
- **the-governor**: Avoid when business alignment or scope review is needed (use `the-steward`).
- **arbiter**: Avoid for designing architecture, implementing features, or replacing normal QA.
- **conductor**: Avoid when a single obvious specialist suffices.
- **cipher**: Avoid for offensive/destructive testing (use `dagger`).
- **cloak**: Avoid for backend logic, security policy, or DB architecture.
- **dagger**: Avoid for code implementation, QA test planning, or production execution.
- **chronicler**: Avoid for UI evaluation or system testing.
- **overseer**: Avoid for architecture design or destructive pressure testing.
- **weaver**: Avoid for code implementation or security policy.
- **scribe**: Avoid for architecture decisions or code implementation.
- **clockwork**: Avoid for modifying UI layouts or writing documentation.
- **ponytail**: Avoid for architecture design, UI/UX decisions, or security policies.

## Canonical References
- [Governance Layer](docs/governance/GOVERNANCE_LAYER.md)
- [Routing Map](ROUTING_MAP.md)

## Index Result
SKILL_INDEX_FORMALIZED
