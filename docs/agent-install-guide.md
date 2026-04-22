# Agent Install Guide

This guide explains how to make Vault Sync available to Codex, Claude Code, and OpenClaw. Vault Sync is only for consuming an existing Vault Git repository as local files. Vault creation and management stay in the app that generated the Vault.

## What You Need

- A Vault Git repository URL.
- A local destination folder, such as `~/Vaults/my-vault`.
- macOS, Linux, or WSL2.
- Git authentication already set up for the Vault repository.

Native Windows PowerShell and Command Prompt are not currently supported. On Windows, run the agent and Vault Sync inside WSL2, and keep the Vault under the WSL filesystem.

## Recommended Paths

Use the most native install path your agent supports:

| Agent | Recommended path | Fallback |
|---|---|---|
| Codex | Plugin marketplace | Skills or manual CLI |
| Claude Code | Agent skills | Direct skill URL or manual CLI |
| OpenClaw | Agent skills or direct skill URL | Manual CLI |

The agent should set up the local mirror, then use normal filesystem tools to read it. It should not use Vault Sync as a search or query layer.

## Codex

### Plugin Marketplace

Add the Vault Sync marketplace:

```bash
codex plugin marketplace add graphlit/vault-sync
```

Then ask Codex:

```text
Use the Vault Sync plugin to set up my Vault from <your-vault-repo-url>.
```

Codex should install `vault-sync`, initialize the local folder, run `vault-sync doctor`, and ask before installing a recurring pull schedule.

### Skills Fallback

If plugin marketplace support is not available, install the skills directly:

```bash
npx skills add graphlit/vault-sync --skill vault-sync-setup
npx skills add graphlit/vault-sync --skill vault-sync-use
```

Then ask Codex:

```text
Use Vault Sync to set up my Vault from <your-vault-repo-url>.
```

### Direct Skill URL

If Codex supports reading a skill from a URL, use one of:

```text
https://raw.githubusercontent.com/graphlit/vault-sync/main/skill.md
https://www.zine.ai/skill.md
https://www.dossium.ai/skill.md
```

## Claude Code

### Agent Skills

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

### Direct Skill URL

If your Claude Code environment supports direct skill URLs, use one of:

```text
https://raw.githubusercontent.com/graphlit/vault-sync/main/skill.md
https://www.zine.ai/skill.md
https://www.dossium.ai/skill.md
```

## OpenClaw

### Skill Install

If OpenClaw supports GitHub-based skill installation, install:

```bash
npx skills add graphlit/vault-sync --skill vault-sync-setup
npx skills add graphlit/vault-sync --skill vault-sync-use
```

Then ask OpenClaw:

```text
Set up Vault Sync for my Vault from <your-vault-repo-url>.
```

### Direct Skill URL

If OpenClaw supports direct skill URLs, use one of:

```text
https://raw.githubusercontent.com/graphlit/vault-sync/main/skill.md
https://www.zine.ai/skill.md
https://www.dossium.ai/skill.md
```

## Manual Fallback

Use this path when an agent cannot install skills or plugins directly:

```bash
git clone https://github.com/graphlit/vault-sync
cd vault-sync
install -m 0755 bin/vault-sync ~/.local/bin/vault-sync

vault-sync init <your-vault-repo-url> ~/Vaults/<name>
vault-sync pull ~/Vaults/<name>
vault-sync doctor ~/Vaults/<name>
```

To keep the Vault fresh:

```bash
vault-sync schedule install ~/Vaults/<name> --every 5m
```

## After Install

Once the Vault is local, point the agent at the folder and say:

```text
Use the local Vault in ~/Vaults/<name>. Read README.md first. Ignore hidden control folders like .git, .zine, .dossium, .graphlit, .claude, and .codex. Use normal file tools to search and read the Markdown files.
```

The agent can use `ls`, `rg`, `sed`, `cat`, and native file reads. Vault Sync should only be used to initialize, pull, check status, schedule pulls, or run diagnostics.

## Validation Checklist

After setup, run:

```bash
vault-sync status ~/Vaults/<name>
vault-sync doctor ~/Vaults/<name>
rg -n "<known term>" ~/Vaults/<name>
```

Expected result:

- `vault-sync status` reports the current local revision.
- `vault-sync doctor` reports Git and repository health.
- `rg` can find text in Markdown files.

If Git authentication fails, authenticate through your normal Git or GitHub CLI flow and retry `vault-sync pull`.
