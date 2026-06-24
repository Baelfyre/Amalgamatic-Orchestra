# Amalgamatic Orchestra Routing Map

This file provides a lightweight, scanner-friendly map of common tasks to the correct specialist skill. Load this file when routing is unclear or when multi-skill coordination is required.

## Governance Layer (Pre-Routing)

All requests pass through the Governance Layer before reaching the routing table:

| Step | Authority | Review Scope |
|---|---|---|
| 1 | `the-steward` | Business alignment, scope, requirements, SDLC documentation |
| 2 | `the-governor` | Legal compliance, privacy, IP, licensing, audit readiness |

If either authority returns `BLOCKED`, the Conductor stops. If `human_review_required: true`, the Conductor pauses until human review completes.

## Routing Rules

| Task Type | Target Skill | Condition |
|-----------|--------------|-----------|
| Business alignment, scope, requirements review | `the-steward` | Validating project direction or SDLC |
| Legal, compliance, privacy, IP, licensing review | `the-governor` | Validating compliance or legal risk |
| UI/UX review, accessibility, frontend layout | `cloak-meister` | Reviewing user-facing visible layers |
| README, documentation, final submission | `scribe-meister` | Source evidence is available to verify claims |
| SQL, schemas, database testing, migrations | `meister-chronicler` | Analyzing data layers or database relationships |
| QA, release readiness, test cases, defects | `acme-overseer` | Normal quality assurance |
| Security, privacy, RBAC, defensive review | `cipher-meister` | Evaluating defensive posture |
| UML, ERD visuals, architecture workflows | `meister-weaver` | Creating or reviewing system models |
| OOP, SOLID, code structure, architecture, refactoring | `clockwork-meister` | Reviewing architecture, layering, or object-oriented design |
| Gated resilience or negative testing | `hidden-dagger` | Requires explicit approval and safe environment |
| Broad, unclear, or multi-skill tasks | `amalgam-conductor` | When ownership overlaps or dependencies exist |

## Conductor Authority

`amalgam-conductor` retains routing authority for complex requests, subject to governance gates. The Conductor will evaluate the project constraints and select the smallest effective skill stack from this map. The Conductor **cannot override** governance decisions from The Steward or The Governor.

## Conflict Resolution

- Assign one owner per output and sequence dependencies.
- Prefer `acme-overseer` for normal QA and `cipher-meister` for normal security/privacy review.
- Use `hidden-dagger` only after its safety gate and never as the default QA, security, database, or UI reviewer.
- For ERDs, use `meister-chronicler` for database semantics and `meister-weaver` for visual notation.
- Do not load or route specialists whose output is not required.
