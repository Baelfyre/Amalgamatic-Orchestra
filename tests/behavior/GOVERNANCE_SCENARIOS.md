# Governance Review Scenarios

Validation scenarios across different project types and risk levels.

---

## Scenario 1: School Project - New Feature

**Context**: School assignment | LOW risk | No public release | No user data

**Steward**:
```
REVIEWER: the-steward
PROJECT_CONTEXT: school | LOW
DECISION: APPROVED
REASON: Feature supports assignment objective, within rubric scope
RISKS: none
REQUIRED_ACTIONS: none
```

**Governor**:
```
REVIEWER: the-governor
PROJECT_CONTEXT: school | LOW
DECISION: NOT_APPLICABLE
HUMAN_REVIEW_REQUIRED: false
REASON: Internal school work, no compliance concerns
RISKS: none
REQUIRED_ACTIONS: none
```

**Result**: Proceeds. Near-zero overhead.

---

## Scenario 2: Open-Source Project - Public Release

**Context**: Open-source library | HIGH risk | Public npm release | MIT license

**Steward**:
```
REVIEWER: the-steward
PROJECT_CONTEXT: open-source | HIGH
DECISION: APPROVED
REASON: Release aligns with roadmap, all features complete
RISKS: none
REQUIRED_ACTIONS: none
```

**Governor**:
```
REVIEWER: the-governor
PROJECT_CONTEXT: open-source | HIGH
DECISION: REVISION_REQUIRED
HUMAN_REVIEW_REQUIRED: true
SUMMARY: NOTICE file missing for bundled Apache-2.0 deps
COMPLIANCE: Concerns found
LEGAL_RISK: low
IP_COPYRIGHT: Concerns found
LICENSING: Requires review
FINDINGS: [NOTICE file missing for 3 bundled dependencies]
RISKS: [Attribution requirements not met for Apache-2.0 deps]
REQUIRED_ACTIONS: [Create NOTICE file, confirm license compat]
DOCUMENTATION_GAPS: [NOTICE file]
TIMESTAMP: 2026-06-24T10:00:00Z
```

**Result**: Paused. NOTICE file needed + human review.

---

## Scenario 3: Internal Tool - Third-Party Asset

**Context**: Internal team tool | MEDIUM risk | Uses icon library | No public users

**Steward**:
```
REVIEWER: the-steward
PROJECT_CONTEXT: internal | MEDIUM
DECISION: APPROVED
REASON: Icon library supports UI requirements
RISKS: none
REQUIRED_ACTIONS: none
```

**Governor**:
```
REVIEWER: the-governor
PROJECT_CONTEXT: internal | MEDIUM
DECISION: APPROVED
HUMAN_REVIEW_REQUIRED: false
REASON: Internal use, icon library license (MIT) compatible
RISKS: none
REQUIRED_ACTIONS: none
```

**Result**: Proceeds.

---

## Scenario 4: Commercial App - User Data Collection

**Context**: Commercial SaaS | HIGH risk | Collects PII | Public users | EU jurisdiction

**Steward**:
```
REVIEWER: the-steward
PROJECT_CONTEXT: commercial | HIGH
DECISION: APPROVED
REASON: Analytics supports product improvement objective
RISKS: none
REQUIRED_ACTIONS: none
```

**Governor**:
```
REVIEWER: the-governor
PROJECT_CONTEXT: commercial | HIGH
DECISION: BLOCKED
HUMAN_REVIEW_REQUIRED: true
SUMMARY: PII collection requires privacy documentation and consent
COMPLIANCE: Non-compliant
LEGAL_RISK: high
PRIVACY_RISK: high
TOS_IMPACT: Update required
PRIVACY_POLICY_IMPACT: Update required
FINDINGS: [No Privacy Policy update, no consent mechanism, no data retention policy, GDPR applies]
RISKS: [GDPR exposure, user trust risk, regulatory fines]
REQUIRED_ACTIONS: [Update Privacy Policy, implement consent, define data retention, GDPR review]
REQUIRED_REMEDIATION: [1. Privacy Policy 2. Cookie consent 3. Data retention schedule 4. Human legal review]
DOCUMENTATION_GAPS: [Privacy Policy, DPA, consent spec, DPIA]
TIMESTAMP: 2026-06-24T10:00:00Z
```

**Result**: BLOCKED until privacy docs complete + human legal review.

---

## Scenario 5: Personal Project - Open-Source Dependency

**Context**: Personal prototype | LOW risk | Adding lodash (MIT)

**Steward**:
```
REVIEWER: the-steward
PROJECT_CONTEXT: personal | LOW
DECISION: NOT_APPLICABLE
REASON: Trivial dependency addition
RISKS: none
REQUIRED_ACTIONS: none
```

**Governor**:
```
REVIEWER: the-governor
PROJECT_CONTEXT: personal | LOW
DECISION: APPROVED
HUMAN_REVIEW_REQUIRED: false
REASON: MIT license, no compatibility concerns
RISKS: none
REQUIRED_ACTIONS: none
```

**Result**: Proceeds. Minimal overhead.

---

## Scenario 6: Client-Facing Project - Scope Change

**Context**: Client web application | HIGH risk | Client contract defines scope

**Steward**:
```
REVIEWER: the-steward
PROJECT_CONTEXT: client-facing | HIGH
DECISION: BLOCKED
SUMMARY: Multi-tenant support not in contract scope
ALIGNMENT: Not aligned with client agreement
SCOPE: Out of scope
REQUIREMENTS: No requirements document
FINDINGS: [Feature not in contract, no client approval, no requirements]
RISKS: [Scope drift, contract violation, resource overrun]
REQUIRED_ACTIONS: [Client approval, contract amendment, requirements document]
DOCUMENTATION_GAPS: [Requirements doc, client sign-off]
TIMESTAMP: 2026-06-24T10:00:00Z
```

**Result**: BLOCKED at Steward. Does not reach Governor.

---

## Scenario 7: Software Project - Missing Requirements

**Context**: Software product | MEDIUM risk | SSO feature in roadmap

**Steward**:
```
REVIEWER: the-steward
PROJECT_CONTEXT: software | MEDIUM
DECISION: REVISION_REQUIRED
REASON: SSO in roadmap but requirements doc missing
ALIGNMENT: Aligned with roadmap
SCOPE: Within scope
REQUIREMENTS: Missing
ACCEPTANCE_CRITERIA: Undefined
FINDINGS: [No SSO requirements doc, no IdP selection]
REQUIRED_ACTIONS: [Create SSO requirements doc, define IdP, define acceptance criteria]
DOCUMENTATION_GAPS: [SSO requirements doc]
TIMESTAMP: 2026-06-24T10:00:00Z
```

**Result**: Returned for revision.

---

## Scenario 8: AI Project - Missing Privacy Documentation

**Context**: AI-assisted tool | HIGH risk | Processes user input | Generates AI output

**Steward**:
```
REVIEWER: the-steward
PROJECT_CONTEXT: research/AI | HIGH
DECISION: APPROVED
REASON: Feature complete, tested, supports product objective
RISKS: none
REQUIRED_ACTIONS: none
```

**Governor**:
```
REVIEWER: the-governor
PROJECT_CONTEXT: research/AI | HIGH
DECISION: BLOCKED
HUMAN_REVIEW_REQUIRED: true
SUMMARY: AI output + user input processing requires privacy and disclosure docs
COMPLIANCE: Non-compliant
LEGAL_RISK: high
PRIVACY_RISK: high
FINDINGS: [No AI disclosure, no user input handling policy, no output liability disclaimer, no bias assessment]
RISKS: [Regulatory exposure, user trust, liability for AI outputs]
REQUIRED_ACTIONS: [AI disclosure, input handling policy, output disclaimer, bias review]
DOCUMENTATION_GAPS: [AI disclosure doc, privacy policy update, output liability terms]
TIMESTAMP: 2026-06-24T10:00:00Z
```

**Result**: BLOCKED until AI-specific documentation complete + human review.

---

## Scenario 9: Missing Project Context

**Context**: Unknown (no context provided)

**Steward**:
```
REVIEWER: the-steward
PROJECT_CONTEXT: unknown | unknown
DECISION: REVISION_REQUIRED
REASON: Project context incomplete
RISKS: Cannot assess without context
REQUIRED_ACTIONS: [Provide project type, release target, documentation requirements]
```

**Result**: Returned for context. No assumptions made.
