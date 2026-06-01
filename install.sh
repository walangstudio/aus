#!/usr/bin/env bash
# Installs the Artificial Unintelligence Skills into your Claude skills folder.
# Usage:
#   ./install.sh              # install for your user (~/.claude/skills)
#   ./install.sh --project    # install into this project (./.claude/skills)
#   ./install.sh --dir PATH   # install into a folder you choose
#   ./install.sh --help

set -euo pipefail

# Where this script lives, so it works no matter where you run it from.
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Every skill in this repo is a top-level folder containing a SKILL.md.
SKILLS=(plain-speak)

TARGET="${HOME}/.claude/skills"

usage() {
  sed -n '2,8p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
  exit "${1:-0}"
}

while [ $# -gt 0 ]; do
  case "$1" in
    --project) TARGET="$(pwd)/.claude/skills"; shift ;;
    --dir)     TARGET="${2:?--dir needs a path}"; shift 2 ;;
    -h|--help) usage 0 ;;
    *) echo "Unknown option: $1" >&2; usage 1 ;;
  esac
done

mkdir -p "$TARGET"

echo "Installing into: $TARGET"
for skill in "${SKILLS[@]}"; do
  if [ ! -f "$SRC_DIR/$skill/SKILL.md" ]; then
    echo "  ! skipping '$skill' (no SKILL.md found)" >&2
    continue
  fi
  if [ -e "$TARGET/$skill" ]; then
    echo "  ~ replacing existing '$skill'"
    rm -rf "${TARGET:?}/$skill"
  else
    echo "  + installing '$skill'"
  fi
  cp -R "$SRC_DIR/$skill" "$TARGET/$skill"
done

echo
echo "Done. Start a new Claude session and just ask for a plain explanation."
echo "ayos. ✅"
