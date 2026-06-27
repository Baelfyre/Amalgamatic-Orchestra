# Release Gates

Release gates enforce governance compliance before any release. **Release Mode** is the strictest governance path in the ecosystem. Formal, comprehensive governance review is mandatory before any release, client delivery, open-source distribution, production deployment, or external publication.

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
| Continuation state verified | Arbiter | Yes |
| Source of truth confirmed | Arbiter | Yes |
| Branch and merge readiness reviewed | Arbiter | Yes |
| QA validation passed | Overseer | Yes |
| No unresolved `BLOCKED` decisions | Governance authorities | Yes |
| No unresolved Arbiter `HOLD` verdicts | Arbiter | Yes |
| No pending `human_review_required` flags | The Governor | Yes |

## Gate Enforcement

- **Release Mode Enforcement**: The Conductor and Governance authorities (The Steward, The Governor, and Arbiter) enforce complete Basis of Review and continuation-state checks for all release activities. Bypassing compliance, scope, validation, or continuity checks is prohibited.
- The Conductor must check for unresolved governance findings before routing release work.
- The Conductor must call Arbiter before merge, pull request, release handoff, or continuation after uncertain state.
- Release-related requests (publish, deploy, tag, distribute, client delivery, or public distribution) require explicit governance clearance.
- High-impact releases require both Steward and Governor `APPROVED` decisions.
- Transition-sensitive releases require Arbiter `READY` or `READY_WITH_MINOR_FIXES`.

## Evidence

Each gate pass should reference the governance review output that cleared it:

```
GATE: license_compatibility
STATUS: PASSED
EVIDENCE: Governor review [timestamp], decision: APPROVED
```

## Enforcement Limitation

Current enforcement is instruction-level governance. The Conductor must follow the governance gate before planning or routing work, but no runtime blocker exists yet. Runtime enforcement may be added later if CI checks, schema validation, or automated release gates become necessary.

