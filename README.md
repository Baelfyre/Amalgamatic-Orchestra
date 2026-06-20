<div align="center">
  <img src="assets/logo/orchestra-of-amalgamation.png" alt="Orchestra of Amalgamation" width="280" />
  <h1>Orchestra of Amalgamation</h1>
  <p>A portable Markdown-based skill system for guiding AI assistants through review, documentation, diagrams, database work, QA, security, and gated resilience testing.</p>
</div>

## What this repository is

Orchestra of Amalgamation is a collection of reusable AI instruction files. Each instruction folder defines a specific specialist role that can help an AI assistant handle a certain type of work more consistently.

The goal is to make AI-assisted project work easier to route, review, and verify. Instead of using one broad prompt for every task, this repository separates responsibilities into focused skills. For example, one skill handles UI/UX review, another handles documentation, another handles database review, and another handles QA readiness.

The main coordinating skill is **Amalgam Conductor**. It helps decide which specialist skill should be used, when multiple skills are needed, and what order they should be used in.

## What this repository is not

This repository is not a complete AI tool by itself. It does not automatically install into every IDE, chatbot, or local model environment.

It also does not include private project context, external plugins, or permission to perform risky actions. Any destructive, production-level, offensive, or pressure-testing activity must be reviewed and approved separately.

## Skills included

| Skill | Purpose | Use when |
|---|---|---|
| [Amalgam Conductor](skills/amalgam-conductor/SKILL.md) | Routes work to the correct specialist skill | The task needs sequencing, multiple skill owners, or unclear responsibility |
| [Cloak Meister](skills/cloak-meister/SKILL.md) | Reviews user-facing software | You need UI, UX, accessibility, layout, forms, dashboards, or responsive design review |
| [Scribe Meister](skills/scribe-meister/SKILL.md) | Reviews and improves documentation | You need README files, reports, audits, handoffs, or technical writing |
| [Meister Weaver](skills/meister-weaver/SKILL.md) | Reviews and creates visual models | You need UML, ERD visuals, architecture diagrams, workflows, or process diagrams |
| [Meister Chronicler](skills/meister-chronicler/SKILL.md) | Reviews database design and evidence | You need schema, SQL, constraints, seed data, migrations, or database documentation reviewed |
| [Acme Overseer](skills/acme-overseer/SKILL.md) | Reviews QA and release readiness | You need test plans, defects, validation, regression checks, or release-readiness review |
| [Cipher Meister](skills/cipher-meister/SKILL.md) | Reviews security and privacy evidence | You need defensive review of authentication, RBAC, secrets, sensitive data, dependencies, or remediation |
| [Hidden Dagger](skills/hidden-dagger/SKILL.md) | Plans gated resilience and negative testing | You have explicit approval for non-production pressure testing, boundary testing, fuzz testing, or failure-mode review |

See [SKILL_INDEX.md](SKILL_INDEX.md) for the full skill index, activation level, and expected output for each skill.

## Recommended routing flow

Use this flow when deciding which skill to apply:

1. Start with **Amalgam Conductor** if the task is broad, unclear, or involves multiple types of work.
2. Route the main task to one primary specialist.
3. Add another specialist only when there is a separate required output.
4. Use **Acme Overseer** for normal QA, validation, regression, and release-readiness review.
5. Use **Cipher Meister** for normal defensive security and privacy review.
6. Use **Hidden Dagger** only when the task is explicitly authorized, scoped, isolated from production, and includes rollback, cleanup, and stop conditions.

If the task is obvious, use the correct specialist directly.

## Installation summary

Clone or download this repository.

```sh
git clone <approved-repository-url> orchestra-of-amalgamation
cd orchestra-of-amalgamation
```

Then copy only the skill folders you need from `skills/` into the instruction or skill location supported by your AI environment.

For Codex-compatible local skills, copy the selected skill folders into the configured local Codex skills directory.

For tools that do not support local skill folders directly, use the Markdown files as workspace instructions, prompt references, or local context.

See [INSTALLATION.md](INSTALLATION.md) and [adapters/](adapters/README.md) for more details.

## Compatibility

This repository is designed to be Markdown-first. That means the core instructions are plain Markdown files that can be adapted across different AI coding environments.

Supported or adaptable workflows may include:

- Codex-compatible local skill folders
- VS Code AI workspace instructions or prompt references
- Antigravity local skill references or adapted Markdown
- Claude Code using the supplied CLAUDE template
- Local AI systems using `SKILL.md` files through prompt context or retrieval

This repository does not guarantee automatic discovery or native integration in every IDE, model runtime, or AI assistant. Tool-specific behavior depends on the current configuration and capabilities of that environment.

See [COMPATIBILITY.md](COMPATIBILITY.md) for more details.

## Git safety

Keep experimental AI instruction files separate from unrelated repositories.

If local instruction files must live inside a project, use `.git/info/exclude` for machine-local exclusions. Use `.gitignore` only when the exclusion should apply to every clone of the repository.

Before staging or committing changes, always check:

```sh
git status
```

## Test prompts

Use these prompts to check whether each skill is being interpreted correctly:

- Amalgam Conductor: `Use $amalgam-conductor to select the smallest skill stack for this task and explain the sequence.`
- Cloak Meister: `Use $cloak-meister to review this interface for task completion, accessibility, and responsive layout.`
- Scribe Meister: `Use $scribe-meister to audit this documentation against the supplied source files.`
- Meister Weaver: `Use $meister-weaver to review this sequence diagram against the supplied workflow.`
- Meister Chronicler: `Use $meister-chronicler to review this schema and migration for integrity and rollback risk.`
- Acme Overseer: `Use $acme-overseer to assess this test plan, regression evidence, and release readiness.`
- Cipher Meister: `Use $cipher-meister to review the supplied authentication, RBAC, secrets, and privacy evidence defensively.`
- Hidden Dagger: `Use $hidden-dagger to create a safety-gated negative-testing plan for this non-production system. Do not execute tests.`

## Validation

Run the structure validator, then run the stale-reference check.

PowerShell:

```powershell
./scripts/validate-structure.ps1
./scripts/check-stale-references.ps1
```

Shell:

```sh
sh ./scripts/validate-structure.sh
sh ./scripts/check-stale-references.sh
```

See [VALIDATION.md](VALIDATION.md) for the complete checklist.

## Contributing and roadmap

Read the following files before proposing changes:

- [CONTRIBUTING.md](CONTRIBUTING.md)
- [ROADMAP.md](ROADMAP.md)
- [CHANGELOG.md](CHANGELOG.md)

## License

Licensed under the MIT License. See [LICENSE](LICENSE).

## External inspiration and plugin disclaimer

[Ponytail](https://github.com/DietrichGebert/ponytail) and Caveman are external tools. They are not part of this repository and must be installed separately from their official sources if desired.

This repository is inspired only by the general idea of clear, focused, and low-filler review behavior. It does not bundle, copy, vendor, or install those external tools.

The official Caveman source link should be added here once it has been verified.
