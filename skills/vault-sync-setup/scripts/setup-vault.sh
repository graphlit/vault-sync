#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: setup-vault.sh <vault-repo-url> [path] [--schedule] [--every 5m]
USAGE
}

if [[ $# -lt 1 ]]; then
  usage >&2
  exit 1
fi

repo_url="$1"
shift

path=""
schedule="false"
every="5m"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --schedule)
      schedule="true"
      shift
      ;;
    --every)
      every="${2:-}"
      if [[ -z "$every" ]]; then
        usage >&2
        exit 1
      fi
      shift 2
      ;;
    -*)
      usage >&2
      exit 1
      ;;
    *)
      if [[ -n "$path" ]]; then
        usage >&2
        exit 1
      fi
      path="$1"
      shift
      ;;
  esac
done

if [[ -z "$path" ]]; then
  name="${repo_url##*/}"
  name="${name%.git}"
  path="$HOME/Vaults/$name"
fi

if ! command -v vault-sync >/dev/null 2>&1; then
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  bash "$script_dir/install-vault-sync.sh"
fi

vault-sync init "$repo_url" "$path"
vault-sync pull "$path"
vault-sync doctor "$path"

if [[ "$schedule" == "true" ]]; then
  vault-sync schedule install "$path" --every "$every"
fi

echo "Vault ready at $path"
