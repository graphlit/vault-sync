# Vault

Use `vault-sync` only to keep a Vault Git repository mirrored locally.

## What `vault-sync` does

- `init` clones an existing Vault repo to a local folder.
- `pull` refreshes the local mirror.
- `status` reports local sync state.
- `schedule install` and `schedule remove` manage recurring pulls.
- `doctor` checks local prerequisites.

## What `vault-sync` does not do

- search
- query
- read content through an API
- summarize
- rank
- index
- create Vaults
- manage replicas
- write changes back to the Vault repo

## How to use a Vault

1. Read `README.md` first.
2. Use `vault-sync pull <path>` to refresh the local copy.
3. Use normal filesystem tools to inspect the Vault:
   - `ls`
   - `rg`
   - `cat`
   - `sed`
   - native file reads from your editor or agent
4. Treat the Vault as read-only unless the user explicitly asks you to edit local files.

## Ignore control folders

Ignore hidden sync folders such as:

- `.git`
- `.zine`
- `.dossium`
- `.graphlit`
- `.claude`
- `.codex`

These folders are implementation details for sync and packaging.

## QMD

If the user has QMD installed and configured for the Vault path, it can be used as an optional local search layer.
Do not require QMD.
Do not make `vault-sync` responsible for search or query.
