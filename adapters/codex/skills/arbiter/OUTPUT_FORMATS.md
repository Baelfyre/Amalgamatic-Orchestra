# Output Formats

## Continuity Review

Use this format for handoff, branch, merge, interruption, workspace-transition, source-of-truth, and validation-state reviews.

```markdown
## Workflow Status
- Current Phase:
- Current Milestone:
- Overall Status:

## Completed
- Verified completed work:

## In Progress
- Active work:

## Remaining
- Next tasks:

## Risks
- Technical:
- Merge:
- Architecture:
- Validation:
- Workflow:

## Validation Summary
- Build Status:
- Test Status:
- Documentation Status:
- Branch Status:
- Configuration Status:
- Merge Readiness:

## Continuation Package
- Current Objective:
- Current Implementation Point:
- Source of Truth:
- Next Recommended Task:
- Known Blockers:
- Dependencies:
- Important Notes:

## Access / Visibility Closeout (Optional)
- Expected Actor:
- Expected Authority Source:
- Actual Authority Source Found:
- Positive Persona Proof:
- Negative Persona Proof:
- Edge-Case Persona Proof:
- Navigation Visibility:
- Direct Route / Screen Switching:
- Backend / Service Authorization:
- Gap Type: policy | data | validation | mixed
- Workaround or Durable Fix:
- Unsupported Cases:
- Final Closeout Decision:

## Final Verdict
READY | READY_WITH_MINOR_FIXES | HOLD | BLOCKED

Justification:
```

Keep entries evidence-based. Use `NOT FOUND` when expected evidence is absent and `NEEDS VERIFICATION` when evidence is unclear.
