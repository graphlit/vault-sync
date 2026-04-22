#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TMPDIR_ROOT="$(mktemp -d)"
SRC="$TMPDIR_ROOT/source"
VAULT="$TMPDIR_ROOT/vault"
CONFIG="$TMPDIR_ROOT/config"

cleanup() {
  rm -rf "$TMPDIR_ROOT"
}
trap cleanup EXIT

git init -b main "$SRC" >/dev/null
git -C "$SRC" config user.email test@example.com
git -C "$SRC" config user.name "Vault Sync Test"

printf '# Test Vault\n\nhello vault\n' >"$SRC/README.md"
git -C "$SRC" add README.md
git -C "$SRC" commit -m 'initial vault' >/dev/null

VAULT_SYNC_CONFIG_DIR="$CONFIG" bash "$ROOT_DIR/bin/vault-sync" init "$SRC" "$VAULT"
VAULT_SYNC_CONFIG_DIR="$CONFIG" bash "$ROOT_DIR/bin/vault-sync" status "$VAULT" >/dev/null
VAULT_SYNC_CONFIG_DIR="$CONFIG" bash "$ROOT_DIR/bin/vault-sync" status "$VAULT" --json >/dev/null

printf '\nsecond line\n' >>"$SRC/README.md"
git -C "$SRC" add README.md
git -C "$SRC" commit -m 'update vault' >/dev/null

VAULT_SYNC_CONFIG_DIR="$CONFIG" bash "$ROOT_DIR/bin/vault-sync" pull "$VAULT"
VAULT_SYNC_CONFIG_DIR="$CONFIG" bash "$ROOT_DIR/bin/vault-sync" doctor "$VAULT"

if VAULT_SYNC_CONFIG_DIR="$CONFIG" bash "$ROOT_DIR/bin/vault-sync" search "$VAULT" >/dev/null 2>&1; then
  printf 'search unexpectedly succeeded\n' >&2
  exit 1
fi

printf 'vault-sync smoke test passed\n'
