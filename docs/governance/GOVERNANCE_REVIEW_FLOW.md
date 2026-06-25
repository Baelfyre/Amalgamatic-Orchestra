# Governance Review Flow

Every request passes through this flow before execution begins. Review depth scales to project risk and the active operating mode.

## Standard User Flow

```
Request
↓
Intent Classification
↓
Mode Selection (Ideation, Prototype, Implementation, Audit, Release)
↓
Need-Based Governance Review (if applicable)
↓
Conductor Routing or Advisory Response
↓
Validation when files change
↓
User Review
```

## Flow Diagram

```
Request
  │
  ▼
┌───────────────────────┐
│ Intent Classification │  Determine user objective
└──────────┬────────────┘
           │
           ▼
┌───────────────────────┐
│    Mode Selection     │  Select: Ideation, Prototype, Implementation,
└──────────┬────────────┘          Audit, or Release mode
           │
           ▼
┌───────────────────────┐
│ Governance Basis check│  Establish review dimensions if required
└──────────┬────────────┘
           │
           ▼
┌───────────────────────┐
│      Need-Based       │  Ideation/Prototype → ADVISORY_ONLY / NOT_APPLICABLE
│   Governance Review   │  Audit/Release → strict validation
└──────────┬────────────┘  Low-risk → Fast path (NOT_APPLICABLE)
           │
     BLOCKED ──► STOP
     REVISION_REQUIRED ──► RETURN for revision
     ADVISORY_ONLY ──► Conductor Routing / Advisory Response
     NOT_APPLICABLE ──► Conductor Routing
     APPROVED ──► Conductor Routing
           │
           ▼
┌───────────────────────┐
│   Conductor   │  Route request (if approved/applicable)
└──────────┬────────────┘
           │
           ▼
┌───────────────────────┐
│       Execution       │  Specialists perform work
└──────────┬────────────┘
           │
           ▼
┌───────────────────────┐
│      Validation       │  QA check if files changed
└──────────┬────────────┘
           │
           ▼
┌───────────────────────┐
│     Release Gate      │  Final compliance check before release
└───────────────────────┘
```

## Fast Path (LOW Risk)

For trivial or low-risk requests:
- Steward returns `NOT_APPLICABLE` or lightweight `APPROVED`.
- Governor returns `NOT_APPLICABLE` or lightweight `APPROVED`.
- Conductor proceeds immediately.
- Governance adds near-zero token overhead.

## Standard Path (MEDIUM Risk)

- Steward checks scope, requirements, acceptance criteria.
- Governor checks license compat, basic privacy, attribution.
- Compact output format used.

## Expanded Path (HIGH Risk)

- Steward checks full alignment, stakeholders, traceability, roadmap.
- Governor checks full compliance, ToS/PP, human review flag.
- Expanded output format used when findings exist.

## Re-submission

When `REVISION_REQUIRED`:
1. Address all findings.
2. Fill documentation gaps.
3. Re-submit for review.
4. Review restarts from the authority that issued the revision.

## Missing Context

When project context is incomplete:
```
DECISION: REVISION_REQUIRED
REASON: Project context incomplete.
REQUIRED_ACTIONS: [Provide project type, release target, data collection status]
```

The system does not default to HIGH-risk assumptions for unknown projects.
