# Vault Sync

Vault Sync keeps a Vault Git repository synced to your computer.

A Vault is a Git repository of Markdown files: notes, source material, transcripts, summaries, observations, and other context exported from your app. Vault Sync keeps those files fresh locally so AI tools can read them without needing a live app connection.

## Who It Helps

Personal knowledge Vaults can keep everyday context available to local AI tools:

- students with lecture notes, readings, and research papers
- researchers cross-referencing papers, citations, and notes
- freelancers juggling client docs, project notes, and emails
- homemakers organizing recipes, household docs, school info, and planning
- job seekers tracking resumes, cover letters, postings, and interview prep
- hobbyists and makers collecting tutorials, references, and project logs
- writers working across drafts, research, notes, and source material

Team and business Vaults can keep operational context available locally:

- engineering and product teams reviewing incident context and feature history
- account executives preparing for calls and relationship updates
- support teams researching incidents, escalations, and account history
- leaders preparing for board meetings, partner syncs, or investor updates
- customer success teams preparing QBRs and account reviews
- deal teams and investors reviewing diligence material and portfolio context

## What It Does

- clones an existing Vault repository to your computer
- pulls updates on demand
- can install a recurring local pull schedule
- reports sync status and local health
- keeps the Vault ready for file-based AI tools

## What It Does Not Do

- does not create or manage your Vault
- does not call back to the app that generated the Vault
- does not search, chat, summarize, rank, or index
- does not edit generated Vault files
- does not push changes back to the Vault repository

Vault Sync is the mirror. Your AI tool is the reader.

## Supported Platforms

Vault Sync currently supports:

- macOS
- Linux
- WSL2 Ubuntu and similar WSL2 Linux distributions

Native Windows PowerShell and Command Prompt usage are not currently supported. If you use Windows, run Vault Sync inside WSL2 and keep the Vault under the WSL filesystem, such as `~/vaults/<name>`, especially when your AI tool also runs in WSL2.

## Agent-First Install

Vault Sync is designed so an AI agent can set up the local mirror with your approval. You provide the Vault repository URL from your app; the agent installs the small `vault-sync` script, clones the repository, and optionally configures a recurring pull schedule.

If your agent supports skill installation from GitHub, install the setup and usage skills:

```bash
npx skills add graphlit/vault-sync --skill vault-sync-setup
npx skills add graphlit/vault-sync --skill vault-sync-use
```

Then ask your agent:

```text
Set up Vault Sync for my Vault at <your-vault-repo-url>.
```

For agents that support direct skill URLs, point them at:

```text
https://raw.githubusercontent.com/graphlit/vault-sync/main/skill.md
```

App-hosted skill entrypoints can also be served at:

```text
https://www.zine.ai/skill.md
https://www.dossium.ai/skill.md
```

Codex CLI `0.121.0` or newer can also consume this repository as a plugin marketplace:

```bash
codex plugin marketplace add graphlit/vault-sync
```

After install, Codex refers to the marketplace by the name in this repo's metadata:

```bash
codex plugin marketplace upgrade graphlit-vault-sync
codex plugin marketplace remove graphlit-vault-sync
```

## Install

Clone this repository and install the script somewhere on your `PATH`:

```bash
git clone https://github.com/graphlit/vault-sync
cd vault-sync
install -m 0755 bin/vault-sync ~/.local/bin/vault-sync
```

If `~/.local/bin` is not on your `PATH`, either add it or run the script directly from this checkout:

```bash
bash bin/vault-sync status ~/vaults/my-vault
```

## Quick Start

Use the Vault repository URL from your app:

```bash
vault-sync init <your-vault-repo-url> ~/vaults/my-vault
vault-sync pull ~/vaults/my-vault
vault-sync status ~/vaults/my-vault
```

Then point your AI tool at the local folder:

```text
~/vaults/my-vault
```

Ask your tool to inspect the Markdown files directly. For example, in Claude Code, Codex, OpenClaw, Cursor, or VS Code:

```text
Use the local Vault in ~/vaults/my-vault to answer this. Start by reading README.md, then search the Markdown files.
```

You can also search the files yourself:

```bash
rg -n "your search terms" ~/vaults/my-vault
```

## Commands

```bash
vault-sync init <repo-url> [path]
vault-sync pull [path]
vault-sync status [path]
vault-sync schedule install [path] --every 5m
vault-sync schedule remove [path]
vault-sync doctor [path]
```

The command surface is intentionally small. Search and reading are handled by your AI tool's normal file access.

## Working With AI Tools

Vault Sync works well with file-aware tools such as:

- Claude Code
- Codex
- OpenClaw
- Cursor
- VS Code

Suggested prompt:

```text
The Vault is a local folder of Markdown files. Read README.md first. Ignore hidden control folders like .git, .zine, .dossium, .graphlit, .claude, and .codex. Use normal file tools to search and read the Markdown files.
```

## Optional: Search Companion With QMD

[QMD](https://github.com/tobi/qmd) is a local search companion for folders full of Markdown. Vault Sync and QMD fit together well:

- Vault Sync keeps the Vault Git repository current on disk.
- QMD can make the synced Markdown easier to search.
- Your agent can still open the actual files whenever it needs the full source.

The workflow is simple: sync the Vault first, then let QMD search the local folder. Install QMD separately, then add the local Vault folder:

```bash
npm install -g @tobilu/qmd

vault-sync pull ~/vaults/my-vault
qmd collection add ~/vaults/my-vault --name my-vault --mask "**/*.md"
qmd context add qmd://my-vault "Local Vault synced by Vault Sync"
qmd embed
```

Then agents can use QMD as an optional search helper:

```bash
qmd query "customer escalation patterns" -c my-vault --json -n 10
qmd get "path/from/result.md" --full
```

QMD is not required. Vault Sync does not install, configure, or depend on QMD; it just keeps the local files fresh so tools like QMD can use them.

## Keeping It Fresh

Pull updates manually:

```bash
vault-sync pull ~/vaults/my-vault
```

Or install a recurring pull schedule:

```bash
vault-sync schedule install ~/vaults/my-vault --every 5m
```

Remove the schedule later:

```bash
vault-sync schedule remove ~/vaults/my-vault
```

## Security

- plain Bash script
- no opaque binary
- no credentials stored by Vault Sync
- Git authentication stays in your existing Git or GitHub setup
- scheduled jobs only run `vault-sync pull <path>`
- local Vault files are not uploaded by this tool

## Troubleshooting

Run:

```bash
vault-sync doctor ~/vaults/my-vault
```

This checks for Git, repository health, local changes, remote reachability, optional `rg`, and scheduler state.

## Agent Install Notes

See:

- [Agent Install Guide](docs/agent-install-guide.md)
- [Claude Code](examples/install-claude-code.md)
- [Codex](examples/install-codex.md)
- [OpenClaw](examples/install-openclaw.md)

These examples are intentionally focused on agent setup and consumption. Vault creation and management stay in the app that generated the Vault.

## Development

Run the smoke test with:

```bash
bash tests/smoke.sh
```

The test creates a temporary local Git repository and does not touch your real Vaults.
