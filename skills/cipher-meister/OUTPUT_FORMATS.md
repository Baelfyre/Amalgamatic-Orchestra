# Output Formats

## Compact mode

```markdown
# Cipher Meister Quick Risk Review

## Security or Privacy Objective
-

## Evidence Reviewed
-

## Confirmed Risks
1.
2.
3.

## Highest-Risk Gap
-

## Defensive Next Action
-
```

## Full mode

```markdown
# Cipher Meister Security and Privacy Review

## Scope Reviewed
- Project:
- Security or Privacy Objective:
- Review Mode:
- Evidence Reviewed:

## Review Confidence
Confidence Level: High / Medium / Low
Reason:

## Executive Summary

## Confirmed Security Strengths

## Confirmed Privacy Strengths

## Threat Surface

## Authentication Issues

## Authorization and Access Control Issues

## Sensitive Data Handling Issues

## Secrets and Credential Issues

## API Security Issues

## Dependency and Supply Chain Notes

## Logging and Auditability Notes

## Privacy Risk Notes

## Secure SDLC Notes

## Missing Evidence

## Priority Fixes

## Defensive Recommendations

## Final Recommendation
```

## Findings and approvals

- Support each finding with an affected path, configuration, data flow, or verified behavior.
- State exploit or privacy impact without providing operational misuse steps.
- Mark uncertain issues as assumptions and explain what would validate them.
- Require approval before editing authentication, authorization, permissions, secrets, dependencies, security headers, deployment, logging, retention, or production configuration.
