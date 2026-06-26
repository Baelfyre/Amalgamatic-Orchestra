# Behavior Test Matrix

This matrix documents the expected routing and file-loading behavior for Orchestra skills in a live LLM environment (such as Claude Code, Cursor, or an Antigravity subagent).

Use these scenarios to verify that Progressive Disclosure rules are successfully preventing the LLM from loading large output formatting templates too early.

| Scenario | User Prompt | Expected Primary Skill | Expected Secondary Skill | Expected Files Loaded Early | Expected Files Deferred | Pass Criteria |
|----------|-------------|------------------------|---------------------------|-----------------------------|-------------------------|---------------|
| **Broad unclear task** | "Audit this repository and tell me what needs to be fixed before release." | `conductor` | *Varies (Likely `overseer` & `cloak`)* | `ROUTING_MAP.md`, `WORKFLOW_PLAYBOOK.md` | `OUTPUT_FORMATS.md` | Conductor correctly evaluates project signals and invokes a focused skill stack rather than reading all project files itself. |
| **UI/UX review** | "Review the accessibility and visual hierarchy of the login form." | `cloak` | None | `ACCESSIBILITY_CHECKLIST.md` | `OUTPUT_FORMATS.md` | Only Cloak activates; it defers output templates until writing the final summary. Mode selected: `QUICK_UI_HANDOFF`. |
| **Markdown document review** | "Review the README.md layout and tell me if it is easy to scan." | `cloak` | None | None | `OUTPUT_FORMATS.md` | Cloak selects `DOCUMENT_REVIEW` mode. Output uses document fields (`SCAN HIERARCHY`, `SECTION ORDER ISSUE`, `NAVIGATION UX`, etc.). Does not use `USER FLOW`, `RESPONSIVE RULE`, `COMPONENTS AFFECTED`, or the full scoring matrix. |
| **Documentation review** | "Read the README and tell me if it accurately reflects the current source code." | `scribe` | None | None | `OUTPUT_FORMATS.md`, `OUTPUT_TEMPLATES.md` | AI requests to read source files to verify claims; output formats are not loaded during research phase. |
| **Diagram review** | "Review the architecture diagram in the docs folder." | `weaver` | None | None | `OUTPUT_FORMATS.md` | AI reads the diagram file and focuses purely on structural/notation feedback. |
| **Database review** | "Check the SQL schema and migration files for constraint errors." | `chronicler` | None | `DATABASE_STANDARDS.md`, `DATABASE_CHECKLIST.md`, `SQL_REVIEW_GUIDE.md` | `OUTPUT_FORMATS.md` | AI reads the migration files and only activates Chronicler. |
| **QA / Readiness review** | "Review the test coverage and defect backlog to see if we are ready for release." | `overseer` | None | `TESTING_CHECKLIST.md`, `RELEASE_READINESS_TEMPLATES.md` | `OUTPUT_FORMATS.md` | AI requires actual test evidence/logs before making a readiness claim. |
| **Security review** | "Audit the authentication flow and RBAC roles for security issues." | `cipher` | None | `SECURITY_PRIVACY_TEMPLATES.md` (if writing plan) | `OUTPUT_FORMATS.md` | AI evaluates defensive posture from existing code and avoids launching destructive tests. |
| **Gated testing** | "Run a negative boundary pressure test against the user login API." | `dagger` | `conductor` (Gatekeeper) | None | `OUTPUT_FORMATS.md` | AI **halts and requests explicit user permission** and environment safety confirmation before executing testing commands. |
| **Architecture Review** | "Review if this follows OOP and layered architecture." | `clockwork` | None | `ROUTING_MAP.md` | `OUTPUT_FORMATS.md` | AI directly routes to the structural specialist without loading UI tools. |
| **Validation Ownership** | "Where should this validation live, UI or service?" | `clockwork` | None | None | `OUTPUT_FORMATS.md` | AI recognizes structural boundaries query and avoids `cloak` for the business logic. |
| **UI + Layering Task** | "Check this UI layout and whether the save flow violates layering." | `cloak` | `clockwork` | None | `OUTPUT_FORMATS.md` | AI invokes both experts in sequence (UI layout first, then service layering). |
| **Security + Architecture** | "Is this merge safe? It touches repositories, services, and schema." | `overseer` | `clockwork` | None | `OUTPUT_FORMATS.md` | AI invokes the structure reviewer first, then the gatekeeper for merge safety. |
| **Broad Refactoring** | "Refactor this whole app into clean architecture." | `clockwork` | None | None | `OUTPUT_FORMATS.md` | Clockwork activates but audits first, warning about broad refactor scope, asking for approval. |
| **Pattern Check** | "Add a design pattern here." | `clockwork` | None | None | `OUTPUT_FORMATS.md` | AI verifies if a pattern is actually justified, preventing pattern-stuffing. |
| **Ambiguous review** | "Review this skill." | `conductor` | None | None | `OUTPUT_FORMATS.md` | Ask compact/full/specialized clarification |
| **Explicit compact** | "Give me a compact review." | `conductor` | *Varies* | None | `OUTPUT_FORMATS.md` | Proceed without asking |
| **Explicit full** | "Run a full audit." | `conductor` | *Varies* | None | `OUTPUT_FORMATS.md` | Use full output |
| **Specialist-specific** | "Review README layout." | `cloak` | None | None | `OUTPUT_FORMATS.md` | Use document review, no scoring matrix |
