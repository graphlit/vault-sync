# Claude Code Install

Use this when a Vault already exists in Git and Claude Code can access your local filesystem.

## Preferred: Agent Skills

Install the setup and usage skills:

```bash
npx skills add graphlit/vault-sync --skill vault-sync-setup
npx skills add graphlit/vault-sync --skill vault-sync-use
```

Then ask Claude Code:

```text
Set up Vault Sync for my Vault from <your-vault-repo-url>.
```

Claude Code should install `vault-sync`, initialize the local folder, run `vault-sync doctor`, and ask before installing a recurring pull schedule.

## Direct Skill Fallback

If your environment uses direct skill URLs, point Claude Code at:

```text
https://raw.githubusercontent.com/graphlit/vault-sync/main/skill.md
```

## Manual Fallback

```bash
git clone https://github.com/graphlit/vault-sync
cd vault-sync
install -m 0755 bin/vault-sync ~/.local/bin/vault-sync

vault-sync init <your-vault-repo-url> ~/Vaults/<name>
vault-sync schedule install ~/Vaults/<name> --every 5m
```

After setup, Claude Code should read `README.md` in the local Vault first, ignore hidden control folders, and inspect Markdown files directly with normal filesystem tools. Treat the Vault as read-only unless you explicitly want local edits.
