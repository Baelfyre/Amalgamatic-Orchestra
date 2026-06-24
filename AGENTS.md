# Amalgam Conductor Ecosystem Guidelines

When operating within this repository or when this plugin is active, adhere to the following routing and execution guidelines:

1. **Routing Layer**: `Amalgam Conductor` is the exclusive router and workflow orchestrator. Do not invent custom subagent chains or bypass the Conductor for complex tasks.
2. **Implementation Layer**: `Ponytail` handles focused implementation, strictly keeping code minimal, reversible, and free of over-engineering.
3. **Communication Layer**: `Caveman` controls output compression to preserve context limits during long multi-file operations.
4. **Domain Specialists**: Specialists (`Clockwork Meister`, `Cloak Meister`, `Cipher Meister`, `Meister Chronicler`, `Meister Weaver`, `Scribe Meister`, `Acme Overseer`, `Hidden Dagger`) exclusively own their respective domains.
5. **Source of Truth**: Do not guess specialist logic or rules. The authoritative source of truth for any skill's behavior is always located in its corresponding `skills/*/SKILL.md` file. Always defer to the explicit instructions in those files.
