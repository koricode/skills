#!/usr/bin/env bash
#
# merge-skills.sh
#
# Moves every folder inside .agents/skills/ into skills/.
# If a folder with the same name already exists in skills/, it is removed
# (including all its contents) before the new one is moved in.
# Afterwards, the .agents/ folder and skills-lock.json are deleted.

set -euo pipefail

# Resolve paths relative to this script's location, so it can be run from anywhere.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SRC_DIR="$SCRIPT_DIR/.agents/skills"
DEST_DIR="$SCRIPT_DIR/skills"
AGENTS_DIR="$SCRIPT_DIR/.agents"
LOCK_FILE="$SCRIPT_DIR/skills-lock.json"

# Sanity checks.
if [[ ! -d "$SRC_DIR" ]]; then
  echo "Error: source directory not found: $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

# Move each top-level folder from .agents/skills/ into skills/.
for src in "$SRC_DIR"/*/; do
  # If the glob matched nothing, the literal pattern is left; skip it.
  [[ -d "$src" ]] || continue

  name="$(basename "$src")"
  dest="$DEST_DIR/$name"

  if [[ -e "$dest" ]]; then
    echo "Removing existing: $dest"
    rm -rf "$dest"
  fi

  echo "Moving: $name -> skills/"
  mv "$src" "$dest"
done

# Clean up.
echo "Removing: $AGENTS_DIR"
rm -rf "$AGENTS_DIR"

if [[ -e "$LOCK_FILE" ]]; then
  echo "Removing: $LOCK_FILE"
  rm -f "$LOCK_FILE"
fi

echo "Done."