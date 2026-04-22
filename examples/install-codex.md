# Codex Install

Use this when a Vault already exists in Git and Codex can access your local filesystem.

## Preferred: Codex Plugin Marketplace

This path requires Codex CLI `0.121.0` or newer.

Add the Vault Sync marketplace:

```bash
codex marketplace add graphlit/vault-sync
```

Then ask Codex:

```text
Use the Vault Sync plugin to set up my Vault from <your-vault-repo-url>.
```

Codex should install `vault-sync`, initialize the local folder, run `vault-sync doctor`, and ask before installing a recurring pull schedule.

## Skill Fallback

If plugin marketplace support is not available in your Codex CLI version, install the skills directly:

```bash
npx skills add graphlit/vault-sync --skill vault-sync-setup
npx skills add graphlit/vault-sync --skill vault-sync-use
```

You can also point Codex at the direct skill entrypoint:

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

After setup, Codex should read `README.md` in the local Vault first, ignore hidden control folders, and inspect Markdown files directly with normal filesystem tools.
