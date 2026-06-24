# Release Gates

Release gates enforce governance compliance before any release.

## Pre-Release Checklist

| Gate | Authority | Must Pass |
|---|---|---|
| Business alignment verified | The Steward | Yes |
| Scope confirmed | The Steward | Yes |
| Requirements traceable | The Steward | Yes |
| Acceptance criteria met | The Steward | Yes |
| SDLC documentation complete | The Steward | Yes |
| Legal compliance confirmed | The Governor | Yes |
| Privacy review completed | The Governor | Yes |
| IP/copyright cleared | The Governor | Yes |
| License compatibility confirmed | The Governor | Yes |
| ToS/Privacy Policy updated (if needed) | The Governor | Yes |
| Human legal review completed (if flagged) | The Governor | Yes |
| Security governance satisfied | The Governor | Yes |
| Audit documentation sufficient | The Governor | Yes |
| QA validation passed | Acme Overseer | Yes |
| No unresolved `BLOCKED` decisions | Both | Yes |
| No pending `human_review_required` flags | The Governor | Yes |

## Gate Enforcement

- The Conductor must check for unresolved governance findings before routing release work.
- Release-related requests (publish, deploy, tag, distribute) require explicit governance clearance.
- High-impact releases require both Steward and Governor `APPROVED` decisions.

## Evidence

Each gate pass should reference the governance review output that cleared it:

```
GATE: license_compatibility
STATUS: PASSED
EVIDENCE: Governor review [timestamp], decision: APPROVED
```

## Enforcement Limitation

Current enforcement is instruction-level governance. The Amalgam Conductor must follow the governance gate before planning or routing work, but no runtime blocker exists yet. Runtime enforcement may be added later if CI checks, schema validation, or automated release gates become necessary.

