# Contributing

- Keep examples fictional, generic, and project-agnostic.
- Exclude private projects, personal data, local paths, credentials, and client details.
- Do not vendor external plugin code or claim unsupported compatibility or compliance.
- Do not add offensive security content or instructions for unauthorized access.
- Before starting a new local development phase or repository-editing session, run `python scripts/preflight_sync_check.py` against `origin/main`. Do not begin edits if the local branch is behind, diverged, dirty, or unverifiable. Ahead-only state may proceed, but the unpublished commits must be reported.
- Preserve specialist ownership, evidence-first findings, progressive disclosure, and local-first safety.
- Preserve Dagger's explicit activation, non-production requirement, approval gate, rollback, cleanup, and stop conditions.
- CI now runs `python scripts/governance_check.py --strict` for deterministic Stage 1 governance failures.
- `main` is governed by an active repository ruleset that requires pull requests, one approval, conversation resolution, and the required GitHub check contexts `governance-check`, `validate`, `Analyze (actions)`, and `Analyze (python)` before merge.
- Direct pushes to `main` are not part of the normal workflow. Use a branch and pull request unless you are an explicitly configured bypass actor handling maintainer-only recovery.
- Signed commits and linear history currently exist in the repository ruleset, but Phase 7 did not change those settings or treat them as newly approved rollout requirements.
- Update `CHANGELOG.md` for significant source, workflow, governance, documentation, skill, command, or security changes. If a changelog update is intentionally not needed, document why in the implementation report.
- Run the validation scripts before submitting changes.

## Standard contribution flow

1. Create a branch from `main`.
2. Make the smallest relevant change set.
3. Run the local validation commands required for the task.
4. Push the branch.
5. Open a pull request targeting `main`.
6. Wait for `governance-check`, `validate`, `Analyze (actions)`, and `Analyze (python)` to pass.
7. Resolve review conversations and obtain at least one approval.
8. Merge only after the required checks and review requirements are satisfied.
