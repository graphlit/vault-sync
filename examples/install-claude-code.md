# Claude Code Install

Use this when your Zine or Dossium Vault is stored in Git and Claude Code can access your local filesystem.

1. Clone Vault Sync.
2. Install the `vault-sync` script on your `PATH`.

```bash
git clone https://github.com/graphlit/vault-sync
cd vault-sync
install -m 0755 bin/vault-sync ~/.local/bin/vault-sync
```

3. Sync your Vault repository from Zine or Dossium:

```bash
vault-sync init <your-vault-repo-url> ~/Vaults/<name>
vault-sync schedule install ~/Vaults/<name> --every 5m
```

4. Open the local Vault folder in Claude Code, such as `~/Vaults/<name>`.
5. Ask Claude Code to read `README.md` first, then inspect Markdown files directly.

Claude Code should treat the Vault as read-only unless you explicitly want to edit local files.
