# Vault Sync

Vault Sync keeps a Graphlit Vault mirrored on your local filesystem so coding agents can read it with ordinary file tools.

This repository is intentionally narrow. It is for consuming an existing Vault Git repository, not for creating or managing Vaults.

## What It Does

- clones a Vault Git repository locally
- pulls updates on demand or on a schedule
- reports sync status and local health
- keeps the Vault ready for `ls`, `rg`, `cat`, `sed`, and native file reads

## What It Does Not Do

- no Graphlit API calls
- no search
- no query
- no read endpoint
- no Vault creation
- no replica management
- no writing changes back to the Vault repository

## Supported Platforms

Initial support is for:

- macOS
- Linux
- WSL2 Ubuntu and similar WSL2 Linux distributions

Native Windows PowerShell and Command Prompt usage are out of scope for the first release. If you use Windows, run Vault Sync inside WSL2 and keep the Vault under the WSL filesystem, such as `~/Vaults/<name>`, especially when your coding agent also runs in WSL2.

## Commands

```bash
vault-sync init <repo-url> [path]
vault-sync pull [path]
vault-sync status [path]
vault-sync schedule install [path] --every 5m
vault-sync schedule remove [path]
vault-sync doctor [path]
```

The command surface stays small on purpose. Search and reading are handled by your agent's own filesystem tools.

## Quick Start

```bash
git clone https://github.com/graphlit/vault-sync
cd vault-sync
install -m 0755 bin/vault-sync ~/.local/bin/vault-sync

vault-sync init <vault-repo-url> ~/Vaults/my-vault
vault-sync pull ~/Vaults/my-vault
vault-sync status ~/Vaults/my-vault
rg -n "your search terms" ~/Vaults/my-vault
```

If you are running directly from a checkout without installing it into your `PATH`, use:

```bash
bash bin/vault-sync status ~/Vaults/my-vault
```

## How Agents Use It

Vault Sync is the mirror. Your agent is the reader.

Use the local Vault with tools you already trust:

- Claude Code
- Codex
- OpenClaw
- Cursor
- VS Code

Agent workflows should read `README.md` first, then inspect Markdown files directly with normal filesystem commands.

## Security

- plain Bash scripts
- no opaque binaries required
- no credentials stored by Vault Sync
- Git auth stays in the user's existing Git or GitHub CLI setup
- scheduled jobs only run `vault-sync pull <path>`

## Development

Run the smoke test with:

```bash
bash tests/smoke.sh
```

The test creates a temporary local Git repository and does not touch your real Vaults.

## Install

See the platform-specific examples:

- [Claude Code](examples/install-claude-code.md)
- [Codex](examples/install-codex.md)
- [OpenClaw](examples/install-openclaw.md)

## Notes

The Vault itself is just files. For larger Vaults, users can optionally add their own local indexing layer on top of the mirrored folder, but that is outside this repository's scope.
