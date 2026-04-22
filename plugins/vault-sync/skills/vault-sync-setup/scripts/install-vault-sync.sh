#!/usr/bin/env bash
set -euo pipefail

install_dir="${VAULT_SYNC_INSTALL_DIR:-$HOME/.local/bin}"
target="$install_dir/vault-sync"

case "$(uname -s)" in
  Darwin|Linux) ;;
  *)
    echo "Vault Sync currently supports macOS, Linux, and WSL2 Linux environments." >&2
    exit 1
    ;;
esac

if ! command -v git >/dev/null 2>&1; then
  echo "git is required before installing Vault Sync." >&2
  exit 1
fi

mkdir -p "$install_dir"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="${VAULT_SYNC_REPO_ROOT:-$(cd "$script_dir/../../.." && pwd)}"

if [[ -f "$repo_root/bin/vault-sync" ]]; then
  install -m 0755 "$repo_root/bin/vault-sync" "$target"
elif command -v curl >/dev/null 2>&1; then
  curl -fsSL https://raw.githubusercontent.com/graphlit/vault-sync/main/bin/vault-sync -o "$target"
  chmod 0755 "$target"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$target" https://raw.githubusercontent.com/graphlit/vault-sync/main/bin/vault-sync
  chmod 0755 "$target"
else
  echo "Install from a checkout or install curl/wget to download Vault Sync." >&2
  exit 1
fi

echo "Installed vault-sync at $target"

case ":$PATH:" in
  *":$install_dir:"*) ;;
  *) echo "Note: $install_dir is not on PATH for this shell." >&2 ;;
esac
