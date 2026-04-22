# Claude Code Install

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

4. Open the local Vault in Claude Code.
5. Use `rg`, `ls`, `cat`, and `sed` against the mirrored folder.

Claude Code should treat the Vault as read-only unless you explicitly want to edit local files.
