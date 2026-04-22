# Vault Sync

Use `vault-sync` only to keep a Vault Git repository mirrored locally.

## Contract

- `vault-sync` mirrors data.
- `vault-sync` does not interpret data.
- `vault-sync` does not provide search or query.
- Claude Code should use its own filesystem tools for discovery and reading.

## Workflow

1. Read `README.md` first.
2. Run `vault-sync pull <path>` before heavy inspection when available.
3. Use normal filesystem tools:
   - `ls`
   - `rg`
   - `cat`
   - `sed`
   - native file reads
4. Treat the Vault as read-only unless the user explicitly asks for local edits.

## Ignore

Ignore sync control folders:

- `.git`
- `.zine`
- `.dossium`
- `.graphlit`
- `.claude`
- `.codex`

## Optional QMD

If QMD is installed and configured for the Vault path, it may be used as an optional local search accelerator.
Do not require it.
