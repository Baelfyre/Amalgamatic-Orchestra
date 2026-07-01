# CI/CD Governance Plan

This document outlines the governance validation foundation for the Orchestra repository. These checks will later be enforced by CI/CD (e.g., GitHub Actions) to act as quality and release gates before merging.

## Phase 1 Objectives
* Define required governance checks.
* Implement a non-destructive validation script (`scripts/governance_check.py`).
* Document critical security gaps (e.g., Dagger runtime guardrail).

## Phase 2 Objectives
* Add a script-level Dagger runtime guardrail (`scripts/dagger_guardrail.py`).
* Keep Dagger in simulation-only mode.
* Produce a structured guardrail report for humans and future CI artifacts.
* Preserve the manifest warning until CI/CD wiring exists.

## Required Governance Checks

The following checks are part of the initial governance validation plan. In Phase 1, they are evaluated in advisory mode (non-blocking).

### 1. Code & Quality Gates
* **Tests:** Required tests must pass.
* **Documentation:** Required documentation must exist.
* **Changelog:** Changelog or context tracker must be updated when relevant.

### 2. Security & Compliance Gates
* **Secrets:** No secrets or forbidden files should be committed.
* **Security Scans:** Security/dependency scan must pass.
* **Optional GESF Audit:** An optional GESF audit score threshold can be enforced as a future enhancement.

### 3. Architecture & Structure Gates
* **Metadata Consistency:** Plugin and manifest metadata (`plugin.json`) must remain consistent and syntactically valid.
* **Skill Structure:** Skill folders must follow the expected structure (`skills/<skill_name>/SKILL.md`).
* **Commands:** Command files must match registered skills.
* **Output Templates:** Output templates must exist for applicable specialists.
* **Output Formats:** Specialist output format must be followed.

## Execution
Validation is currently performed via the non-destructive `scripts/governance_check.py` script plus the simulation-only `scripts/dagger_guardrail.py` validator and `scripts/test_dagger_guardrail.py`.

Strict CI wiring for Dagger remains deferred to Phase 3.
