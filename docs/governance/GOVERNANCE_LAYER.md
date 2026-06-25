# Governance Layer

The Governor and The Steward form a reusable governance layer that sits above the Conductor. Their purpose is to ensure that any project, product, repository, or future development effort remains aligned with its objectives, documentation requirements, compliance obligations, legal risk boundaries, privacy expectations, IP and copyright concerns, licensing requirements, and release readiness standards.

## Architecture

```
Governance Layer
├── The Steward    (Business, Scope, SDLC)
├── The Governor   (Legal, Compliance, Privacy, IP)

Orchestration Layer
└── Conductor

Execution Layer
├── Skills (Specialists)
├── Agents
├── Tools
└── Implementation Workers
```

## Design Principles

- **Project-Agnostic**: Works with any project type (school, personal, internal, open-source, commercial, client-facing, research).
- **Context-Aware**: Adapts to the specific project context profile.
- **Risk-Scaled**: Adjusts review depth based on project risk level (LOW / MEDIUM / HIGH).
- **Token-Efficient**: Uses compact output by default, expands only when findings exist.
- **Markdown-First**: All governance artifacts are plain Markdown.
- **Skill-Compatible**: Integrates with the Orchestra skill ecosystem.
- **Reusable**: No hard-coded assumptions about any specific project or platform.

## Project Context Profile

Before governance review, the system identifies the project context:

```
Project Name:
Project Type: [school | personal | internal | open-source | commercial | client-facing | research | other]
Project Purpose:
Target Users:
Internal or Public:
Open Source or Private:
Data Collected: [none | non-sensitive | sensitive | PII | financial | health]
Data Sensitivity: [none | low | medium | high]
Jurisdiction: [not applicable | specify]
Known Legal or Compliance Requirements:
Third-Party Dependencies:
Third-Party Assets:
Release Stage: [prototype | development | staging | production | maintenance]
Risk Level: [LOW | MEDIUM | HIGH]
Required Documentation:
```

## Governance Basis of Review

The Steward and The Governor do not apply absolute or pre-assumed governance rules. Instead, they first establish the **Governance Basis of Review** from the supplied or discoverable context:
- Project Context
- Declared Objectives
- Requirements and Acceptance Criteria
- Release Target
- Data Use
- Jurisdiction or Applicable Rules
- Dependencies and Third-Party Assets
- Documentation Requirements
- Known Constraints

### No-Assumption Rule
The governance layer operates contextually. Authorities do not pre-assume jurisdiction, legal obligations, business goals, or requirements. They must review *only* against what is stated or discoverable in the project context.

### Context-Missing Behavior
If the project context profile is incomplete, unclear, or entirely missing, the Steward and Governor must not guess or make assumptions.
- In **Audit**, **Release**, or high-risk **Implementation** modes, they must return `REVISION_REQUIRED` to request the necessary clarity.
- In **Ideation** or **Prototype** mode, they return `ADVISORY_ONLY` or `NOT_APPLICABLE` to allow exploration to proceed without blocking.

## Freedom-First Development

Conductor prioritizes freedom-first, need-based development. The ecosystem ensures that ideation, brainstorming, prototyping, and concept exploration are not restricted by early governance requirements. Governance checks activate only when a task moves into implementation, when files or architecture change, or when risk triggers are explicitly hit.

## Need-To-Only Governance

The Governor and The Steward operate on a need-to-only basis. They must not interrupt early-stage planning, rough drafting, or prompt refinement. Full formal checks are reserved for high-impact phases (like Release or Audit), while lightweight, non-blocking pathways are used for low-risk work.

## Operating Modes

To support this freedom-first model, the ecosystem defines 5 operating modes:

1. **Ideation Mode**
   - **Purpose**: Brainstorming, comparing options, rough planning, concept development, prompt refinement.
   - **Governance**: Unblocked. Project context is not required. Governance returns `ADVISORY_ONLY` or `NOT_APPLICABLE` and must not block the user.
2. **Prototype Mode**
   - **Purpose**: Local-only experiments, throwaway proofs-of-concept.
   - **Governance**: Dynamic and lightweight. Full context is not required unless the task handles user data, security-sensitive code, or third-party assets.
3. **Implementation Mode**
   - **Purpose**: Modifying source code, database structures, documentation, or architecture.
   - **Governance**: Flexible. Uses fast path by default. Requires minimum context only. Escalate to expanded review only if risk triggers (user data, licensing, security) appear.
4. **Audit Mode**
   - **Purpose**: Explicit requests for compliance audits, risk reviews, or structural assessments.
   - **Governance**: Context-heavy. Requires full Basis of Review context.
5. **Release Mode**
   - **Purpose**: Deploying to production, public releases, client delivery, or open-source distribution.
   - **Governance**: Strictest path. Fully enforces compliance, license compatibility, and privacy validation.

## Usage Pattern

To interact with the governance layer, requests must be structured to explicitly declare the project context:

### 1. Project Context Dimensions

| Context Dimension | Purpose |
|---|---|
| Project Type | Guides review complexity based on environment (e.g., school project, public commercial release) |
| Goal | Defines the target objective for alignment checking |
| Release Target | Establishes where the software will be deployed (e.g., local-only, public SaaS) |
| Data Use | Declares whether PII, financial, health, or non-sensitive data is processed |
| Dependencies | Lists all third-party libraries, assets, APIs, or AI models involved |
| Constraints | Documents structural, legal, or policy constraints that must be preserved |
| Expected Output | Details the target output artifacts (e.g., changed files, validation checks) |

### 2. Standard Prompt Pattern

```text
[@ponytail] use amalgam-conductor for this task

Project Context:
Project Type:
Goal:
Release Target:
Data Use:
Dependencies or Third-Party Assets:
Constraints:

Task:
Describe the work clearly.

Requirements:
- List what must be changed.
- List what must be preserved.
- List any rules the implementation must follow.

Expected Output:
Changed Files:
Summary:
Validation Results:
Remaining Risks:
Next Recommended Step:
```



## Risk Classification

| Risk Level | Criteria | Review Depth |
|---|---|---|
| `LOW` | School work, personal prototype, no public release, no user data, no commercial use | Lightweight |
| `MEDIUM` | Internal tool, team project, third-party deps, limited exposure | Standard |
| `HIGH` | Public release, PII, payments, AI outputs, legal/health/finance domain, commercial use | Expanded + human review |

## Authority Flow

1. **Request enters** the system.
2. **The Steward** validates alignment, scope, requirements, documentation (scaled to risk).
3. **The Governor** validates compliance, privacy, IP, licensing, audit readiness (scaled to risk).
4. **Conductor** receives the approved request and routes to execution skills.
5. **Execution skills** perform the work.
6. **Validation** confirms outputs.
7. **Release Gate** checks governance compliance before release.

## Decision Model

All governance reviews use the same decision values:

| Decision | Meaning |
|---|---|
| `APPROVED` | Proceed to next stage |
| `ADVISORY_ONLY` | Advice given, exploration unblocked |
| `REVISION_REQUIRED` | Address findings before proceeding |
| `BLOCKED` | Cannot proceed until resolved |
| `NOT_APPLICABLE` | No review needed for this request |

The Governor adds `human_review_required` for uncertain legal, regulatory, privacy, licensing, or IP issues.

## Default Output Format

```
REVIEWER: [the-steward | the-governor]
PROJECT_CONTEXT: [project type] | [risk level]
DECISION: [APPROVED | ADVISORY_ONLY | REVISION_REQUIRED | BLOCKED | NOT_APPLICABLE]
REASON: [one-line assessment]
RISKS: [identified risks or "none"]
REQUIRED_ACTIONS: [actions needed or "none"]
```

## Gate Rules

- Conductor stops on `BLOCKED` from either authority.
- Conductor pauses on `human_review_required: true` until human review completes.
- Conductor addresses all findings on `REVISION_REQUIRED`.
- Execution agents cannot bypass governance gates.
- Governance authorities produce decisions, not code.

## Separation of Concerns

| Layer | Owns | Does Not Own |
|---|---|---|
| The Steward | Business goals, scope, requirements, SDLC | Legal, compliance, IP, licensing, implementation |
| The Governor | Legal, compliance, privacy, IP, licensing | Business alignment, scope, implementation |
| Conductor | Routing, orchestration, skill selection | Governance decisions, implementation |
| Execution Skills | Implementation, code changes | Governance, routing |

## Enforcement Limitation

Current enforcement is instruction-level governance. The Conductor must follow the governance gate before planning or routing work, but no runtime blocker exists yet. Runtime enforcement may be added later if CI checks, schema validation, or automated release gates become necessary.

---

*See [STEWARD.md](STEWARD.md), [GOVERNOR.md](GOVERNOR.md), [GOVERNANCE_REVIEW_FLOW.md](GOVERNANCE_REVIEW_FLOW.md), and [RELEASE_GATES.md](RELEASE_GATES.md) for details.*

