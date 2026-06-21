# Amalgamatic Orchestra Routing Map

This file provides a lightweight, scanner-friendly map of common tasks to the correct specialist skill. Load this file when routing is unclear or when multi-skill coordination is required.

## Routing Rules

| Task Type | Target Skill | Condition |
|-----------|--------------|-----------|
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

`amalgam-conductor` retains routing authority for complex requests. The Conductor will evaluate the project constraints and select the smallest effective skill stack from this map.

## Conflict Resolution

- Assign one owner per output and sequence dependencies.
- Prefer `acme-overseer` for normal QA and `cipher-meister` for normal security/privacy review.
- Use `hidden-dagger` only after its safety gate and never as the default QA, security, database, or UI reviewer.
- For ERDs, use `meister-chronicler` for database semantics and `meister-weaver` for visual notation.
- Do not load or route specialists whose output is not required.
