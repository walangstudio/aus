#!/usr/bin/env bash
# Installs the Artificial Unintelligence Skills (skill + slash commands)
# into your Claude config folder.
#
# Usage:
#   ./install.sh              # install for your user (~/.claude)
#   ./install.sh --project    # install into this project (./.claude)
#   ./install.sh --dir PATH   # install into a .claude folder you choose
#   ./install.sh --help

set -euo pipefail

# Where this script lives, so it works no matter where you run it from.
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Each skill is a top-level folder containing a SKILL.md.
SKILLS=(plain-speak)

BASE="${HOME}/.claude"

usage() {
  sed -n '2,9p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
  exit "${1:-0}"
}

while [ $# -gt 0 ]; do
  case "$1" in
    --project) BASE="$(pwd)/.claude"; shift ;;
    --dir)     BASE="${2:?--dir needs a path}"; shift 2 ;;
    -h|--help) usage 0 ;;
    *) echo "Unknown option: $1" >&2; usage 1 ;;
  esac
done

SKILLS_DIR="$BASE/skills"
COMMANDS_DIR="$BASE/commands"
mkdir -p "$SKILLS_DIR" "$COMMANDS_DIR"

echo "Installing into: $BASE"

echo "Skills -> $SKILLS_DIR"
for skill in "${SKILLS[@]}"; do
  if [ ! -f "$SRC_DIR/$skill/SKILL.md" ]; then
    echo "  ! skipping '$skill' (no SKILL.md found)" >&2
    continue
  fi
  if [ -e "$SKILLS_DIR/$skill" ]; then
    echo "  ~ replacing '$skill'"
    rm -rf "${SKILLS_DIR:?}/$skill"
  else
    echo "  + installing '$skill'"
  fi
  cp -R "$SRC_DIR/$skill" "$SKILLS_DIR/$skill"
done

echo "Commands -> $COMMANDS_DIR"
if [ -d "$SRC_DIR/commands" ]; then
  for cmd in "$SRC_DIR"/commands/*.md; do
    [ -e "$cmd" ] || continue
    name="$(basename "$cmd")"
    [ -e "$COMMANDS_DIR/$name" ] && echo "  ~ replacing /${name%.md}" || echo "  + installing /${name%.md}"
    cp "$cmd" "$COMMANDS_DIR/$name"
  done
fi

echo
echo "Done. Start a new Claude session, then try /aus, /tldr, /eli, or /huh."
echo "ayos. ✅"
