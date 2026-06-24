# Compatibility

This repository is Markdown-first and portable across AI coding environments that accept instruction files.

- **Codex:** Use direct skill folders when supported by local Codex conventions.
- **VS Code AI workflows:** Use selected files as workspace instructions, prompt references, or local context.
- **Antigravity:** Use local skill references where supported, otherwise adapt the selected Markdown.
- **Claude Code:** Use the supplied CLAUDE template and reference selected skill files through repository context.
- **Local AI systems:** Load `SKILL.md` through prompt context or retrieval, then load supporting files only when needed.

The repository does not guarantee native integration or automatic discovery in every IDE or model runtime. Tool-specific loading depends on current configuration and capabilities. Use the adapter templates and manual context when uncertain.
