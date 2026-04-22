# OpenClaw Install

Use this when a Vault already exists in Git and OpenClaw can access your local filesystem.

## Preferred: Skill Entry

If OpenClaw can install agent skills from GitHub, install:

```bash
npx skills add graphlit/vault-sync --skill vault-sync-setup
npx skills add graphlit/vault-sync --skill vault-sync-use
```

If it uses direct skill URLs, point it at:

```text
https://raw.githubusercontent.com/graphlit/vault-sync/main/skill.md
```

Then ask OpenClaw:

```text
Set up Vault Sync for my Vault from <your-vault-repo-url>.
```

OpenClaw should install `vault-sync`, initialize the local folder, run `vault-sync doctor`, and ask before installing a recurring pull schedule.

## Manual Fallback

```bash
git clone https://github.com/graphlit/vault-sync
cd vault-sync
install -m 0755 bin/vault-sync ~/.local/bin/vault-sync

vault-sync init <your-vault-repo-url> ~/vaults/<name>
vault-sync schedule install ~/vaults/<name> --every 5m
```

After setup, OpenClaw should read `README.md` in the local Vault first, ignore hidden control folders, and inspect Markdown files directly with normal filesystem tools.
