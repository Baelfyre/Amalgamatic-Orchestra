# Installation

## Plugin Installation

Amalgam Conductor can be installed directly as an AI workflow plugin:

```sh
agy plugin install https://github.com/Baelfyre/amalgam-conductor
```


## Clone or download manually

If you prefer not to use the plugin manager, you can still clone the repository:

```sh
git clone https://github.com/Baelfyre/amalgam-conductor.git
cd amalgam-conductor
```

## Install selected skills locally

Copy only the folders you need from `skills/` into the local skill or instruction location supported by your tool. For Codex-compatible environments, install Amalgam Conductor plus selected specialists in the configured local Codex skills directory.

Keep the repository copy separate from unrelated source repositories. If you deliberately use repo-local instructions, copy or reference only the required skill text and follow [LOCAL_ONLY_GUIDE.md](LOCAL_ONLY_GUIDE.md).

## Verify

Run the structure validator, then try the test prompts in [README.md](README.md). Confirm that normal QA routes to Acme Overseer, normal security/privacy review routes to Cipher Meister, and Hidden Dagger remains gated.
