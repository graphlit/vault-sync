# Codex Install

1. Clone this repository.
2. Install the `vault-sync` script in your PATH.

```bash
git clone https://github.com/graphlit/vault-sync
cd vault-sync
install -m 0755 bin/vault-sync ~/.local/bin/vault-sync
```

3. Run:

```bash
vault-sync init <vault-repo-url> ~/Vaults/<name>
vault-sync schedule install ~/Vaults/<name> --every 5m
```

4. Point Codex at the local Vault folder.
5. Read content with normal filesystem tools instead of asking Vault Sync to search it.

Codex should load `README.md` first, then read the relevant Markdown files directly.
