#!/usr/bin/env bash
# Mirror the vault's Claude config into vault/ so git tracks it.
#
# Copies only: the root CLAUDE.md, each class folder's CLAUDE.md, and Misc/Templates/.
# Never copies notes, Files/, or .obsidian/.
#
# The vault is the source of truth for these files — edit them there (in Obsidian
# or nvim), then run this script and commit. Skills are the opposite: they live in
# this repo's skills/ and are edited here.
#
# Usage: scripts/sync-from-vault.sh   (override the vault path with VAULT=...)

set -euo pipefail

VAULT="${VAULT:-$HOME/Library/CloudStorage/OneDrive-ImperialCollegeLondon/Year 3}"
REPO="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$REPO/vault"

if [[ ! -d "$VAULT" ]]; then
	echo "Vault not found: $VAULT" >&2
	exit 1
fi

# Rebuild the mirror from scratch so files removed from the vault disappear here too.
rm -rf "$OUT"
mkdir -p "$OUT"

copy() {
	mkdir -p "$(dirname "$OUT/$1")"
	cp "$VAULT/$1" "$OUT/$1"
}

[[ -f "$VAULT/CLAUDE.md" ]] && copy "CLAUDE.md"

for dir in "$VAULT"/*/; do
	name="$(basename "$dir")"
	[[ -f "$dir/CLAUDE.md" ]] && copy "$name/CLAUDE.md"
done

if [[ -d "$VAULT/Misc/Templates" ]]; then
	for f in "$VAULT/Misc/Templates"/*.md; do
		[[ -f "$f" ]] && copy "Misc/Templates/$(basename "$f")"
	done
fi

echo "Synced into $OUT:"
(cd "$OUT" && find . -type f | sort)
