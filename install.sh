#!/usr/bin/env bash
# Installs the Artificial Unintelligence Skills (skill + slash commands)
# into your Claude config folder.
#
# Usage:
#   ./install.sh              # install for your user (~/.claude)
#   ./install.sh --project    # install into this project (./.claude)
#   ./install.sh --dir PATH   # install into a .claude folder you choose
#   ./install.sh --desktop    # build plain-speak.zip to upload to Claude Desktop
#   ./install.sh --help

set -euo pipefail

# Where this script lives, so it works no matter where you run it from.
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Each skill is a top-level folder containing a SKILL.md.
SKILLS=(plain-speak)

BASE="${HOME}/.claude"
DESKTOP=0

usage() {
  sed -n '2,10p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
  exit "${1:-0}"
}

while [ $# -gt 0 ]; do
  case "$1" in
    --project) BASE="$(pwd)/.claude"; shift ;;
    --dir)     BASE="${2:?--dir needs a path}"; shift 2 ;;
    --desktop) DESKTOP=1; shift ;;
    -h|--help) usage 0 ;;
    *) echo "Unknown option: $1" >&2; usage 1 ;;
  esac
done

# Claude Desktop (and claude.ai) has no drop-in skills folder. You add a skill by
# uploading a zip of its folder in Settings > Customize > Skills > Create skill.
# So for --desktop we just build that zip and tell you what to do with it.
if [ "$DESKTOP" -eq 1 ]; then
  command -v zip >/dev/null 2>&1 || { echo "error: 'zip' not found on PATH" >&2; exit 1; }
  for skill in "${SKILLS[@]}"; do
    [ -f "$SRC_DIR/$skill/SKILL.md" ] || { echo "  ! skipping '$skill' (no SKILL.md)" >&2; continue; }
    out="$SRC_DIR/$skill.zip"
    rm -f "$out"
    ( cd "$SRC_DIR" && zip -r -q "$skill.zip" "$skill" )
    echo "Built $out"
  done
  echo
  echo "To use these in the Claude Desktop app or claude.ai:"
  echo "  1. Open Settings > Customize > Skills."
  echo "  2. Click '+ Create skill' and upload the .zip above."
  echo "  3. Toggle the skill on."
  echo "Note: the /aus, /tldr, /eli, /huh slash commands are Claude Code only and"
  echo "do not appear in the desktop or web app."
  exit 0
fi

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
