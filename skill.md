---
name: vault-sync
description: Use when a user wants an AI agent to install Vault Sync, mirror an existing Vault Git repository to local files, keep it refreshed, or consume an already-synced Vault with normal filesystem tools.
---

# Vault Sync

Vault Sync mirrors an existing Vault Git repository onto the user's local filesystem. Use it only for file sync and local readiness. Do not use it for search, query, chat, indexing, Vault creation, or Vault management.

## When Setting Up

1. Confirm the environment is macOS, Linux, or WSL2. Native Windows PowerShell and Command Prompt are out of scope.
2. Check for `bash` and `git`. `rg` is optional but useful after sync.
3. Install `vault-sync` if it is not already on `PATH`:

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/graphlit/vault-sync/main/bin/vault-sync -o ~/.local/bin/vault-sync
chmod +x ~/.local/bin/vault-sync
```

4. Ask for the Vault Git repository URL and local folder if the user did not provide them. A good default is `~/Vaults/<name>`.
5. Run:

```bash
vault-sync init <vault-repo-url> <path>
vault-sync pull <path>
vault-sync doctor <path>
```

6. If the user wants recurring refreshes, install a pull schedule:

```bash
vault-sync schedule install <path> --every 5m
```

## When Using A Synced Vault

1. Refresh first when practical:

```bash
vault-sync pull <path>
```

2. Read `<path>/README.md` first.
3. Ignore hidden control folders such as `.git`, `.zine`, `.dossium`, `.graphlit`, `.claude`, and `.codex`.
4. Use ordinary filesystem tools: `ls`, `rg`, `sed`, `cat`, and native file reads.
5. Treat the Vault as read-only unless the user explicitly asks to edit local files.

## Optional QMD Search Companion

If QMD is installed and the user wants a stronger local search helper, add the synced Vault folder as a QMD collection:

```bash
qmd collection add <path> --name <name> --mask "**/*.md"
qmd context add qmd://<name> "Local Vault synced by Vault Sync"
qmd embed
```

Use QMD to find likely files; use file reads for the full source.

Vault Sync is the mirror. The agent is the reader.
