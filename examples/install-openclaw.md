# OpenClaw Install

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

4. Configure OpenClaw to work from the local Vault folder.
5. Use OpenClaw's own file-reading tools for discovery and retrieval.

OpenClaw can manage the recurring pull schedule, but the scheduled action should still only run `vault-sync pull <path>`.
