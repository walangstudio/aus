#!/usr/bin/env bash
# Installs the Artificial Unintelligence Skills (skill + slash commands)
# into your Claude config folder.
#
# Usage:
#   ./install.sh              # install/update for your user (~/.claude)
#   ./install.sh --project    # install into this project (./.claude)
#   ./install.sh --dir PATH   # install into a .claude folder you choose
#   ./install.sh --desktop    # build plain-speak.zip to upload to Claude Desktop
#   ./install.sh --status     # show installed vs. available version
#   ./install.sh --uninstall  # remove the skill and commands
#   ./install.sh --force      # reinstall without prompting
#   ./install.sh --version    # print the version of this source
#   ./install.sh --help

set -euo pipefail

# Where this script lives, so it works no matter where you run it from.
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Each skill is a top-level folder containing a SKILL.md.
SKILLS=(plain-speak)

# Single source of truth for the version. A marker file with this number is
# written into the install dir so re-running can tell install from update.
VERSION="$(tr -d '[:space:]' < "$SRC_DIR/VERSION" 2>/dev/null || echo "0.0.0")"
MARKER=".aus-version"
RAW_VERSION_URL="https://raw.githubusercontent.com/walangstudio/aus/main/VERSION"

BASE="${HOME}/.claude"
DESKTOP=0; UNINSTALL=0; STATUS=0; FORCE=0

usage() { sed -n '2,13p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit "${1:-0}"; }

# Returns: 0 equal, 1 if $1 > $2, 2 if $1 < $2. Pads missing parts with 0.
ver_cmp() {
  [ "$1" = "$2" ] && return 0
  local IFS=.
  local i a=($1) b=($2)
  for ((i=0; i<3; i++)); do
    local x=${a[i]:-0} y=${b[i]:-0}
    if [ "$x" -gt "$y" ] 2>/dev/null; then return 1; fi
    if [ "$x" -lt "$y" ] 2>/dev/null; then return 2; fi
  done
  return 0
}

while [ $# -gt 0 ]; do
  case "$1" in
    --project)   BASE="$(pwd)/.claude"; shift ;;
    --dir)       BASE="${2:?--dir needs a path}"; shift 2 ;;
    --desktop)   DESKTOP=1; shift ;;
    --uninstall) UNINSTALL=1; shift ;;
    --status)    STATUS=1; shift ;;
    -f|--force)  FORCE=1; shift ;;
    --version)   echo "aus $VERSION"; exit 0 ;;
    -h|--help)   usage 0 ;;
    *) echo "Unknown option: $1" >&2; usage 1 ;;
  esac
done

SKILLS_DIR="$BASE/skills"
COMMANDS_DIR="$BASE/commands"

# Claude Desktop (and claude.ai) has no drop-in skills folder. You add a skill by
# uploading a zip of its folder in Settings > Customize > Skills > Create skill.
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
  echo "  1. Open Settings > Capabilities > Skills (click Customize)."
  echo "  2. Click '+ Create skill' / 'upload a skill' and pick the .zip above."
  echo "  3. Toggle the skill on."
  echo "Slash commands (/aus, /tldr, /eli, /huh) are Claude Code only; on Desktop"
  echo "just talk ('in plain English', 'tl;dr', 'eli5') and the skill triggers."
  exit 0
fi

if [ "$STATUS" -eq 1 ]; then
  echo "Source version:    $VERSION"
  if [ -f "$BASE/$MARKER" ]; then
    echo "Installed version: $(tr -d '[:space:]' < "$BASE/$MARKER") ($BASE)"
  else
    echo "Installed version: not installed ($BASE)"
  fi
  # Best-effort latest-version check; stays quiet when offline.
  latest=""
  if command -v curl >/dev/null 2>&1; then
    latest="$(curl -fsSL --max-time 5 "$RAW_VERSION_URL" 2>/dev/null | tr -d '[:space:]')"
  elif command -v wget >/dev/null 2>&1; then
    latest="$(wget -qO- --timeout=5 "$RAW_VERSION_URL" 2>/dev/null | tr -d '[:space:]')"
  fi
  if [ -n "$latest" ]; then
    set +e; ver_cmp "$latest" "$VERSION"; cmp=$?; set -e
    if [ "$cmp" -eq 1 ]; then
      echo "Latest on GitHub:  $latest — update available. Pull and re-run ./install.sh"
    else
      echo "Latest on GitHub:  $latest — you are up to date."
    fi
  fi
  exit 0
fi

if [ "$UNINSTALL" -eq 1 ]; then
  echo "Removing from: $BASE"
  for skill in "${SKILLS[@]}"; do
    if [ -e "$SKILLS_DIR/$skill" ]; then
      rm -rf "${SKILLS_DIR:?}/$skill"; echo "  - skill $skill"
    fi
  done
  if [ -d "$SRC_DIR/commands" ]; then
    for cmd in "$SRC_DIR"/commands/*.md; do
      [ -e "$cmd" ] || continue
      name="$(basename "$cmd")"
      [ -e "$COMMANDS_DIR/$name" ] && { rm -f "$COMMANDS_DIR/$name"; echo "  - /${name%.md}"; }
    done
  fi
  rm -f "$BASE/$MARKER"
  echo "Done. Removed the skill and commands (left other files in $BASE alone)."
  exit 0
fi

mkdir -p "$SKILLS_DIR" "$COMMANDS_DIR"

# Tell install from update by comparing the marker to the source version.
if [ -f "$BASE/$MARKER" ]; then
  installed="$(tr -d '[:space:]' < "$BASE/$MARKER")"
  set +e; ver_cmp "$installed" "$VERSION"; cmp=$?; set -e
  case $cmp in
    0) echo "v$VERSION already installed in $BASE."
       if [ "$FORCE" -ne 1 ]; then
         read -r -p "Reinstall? [y/N] " ans; [[ "$ans" =~ ^[Yy]$ ]] || { echo "Nothing to do."; exit 0; }
       fi ;;
    1) echo "Installed v$installed is newer than this source v$VERSION."
       if [ "$FORCE" -ne 1 ]; then echo "Use --force to downgrade."; exit 0; fi
       echo "Forcing downgrade to v$VERSION..." ;;
    2) echo "Updating $BASE from v$installed to v$VERSION..." ;;
  esac
else
  echo "Installing v$VERSION into: $BASE"
fi

echo "Skills -> $SKILLS_DIR"
for skill in "${SKILLS[@]}"; do
  if [ ! -f "$SRC_DIR/$skill/SKILL.md" ]; then
    echo "  ! skipping '$skill' (no SKILL.md found)" >&2; continue
  fi
  if [ -e "$SKILLS_DIR/$skill" ]; then
    echo "  ~ replacing '$skill'"; rm -rf "${SKILLS_DIR:?}/$skill"
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

echo "$VERSION" > "$BASE/$MARKER"
echo
echo "Done (v$VERSION). Start a new Claude session, then try /aus, /tldr, /eli, or /huh."
