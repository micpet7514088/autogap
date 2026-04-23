#!/usr/bin/env bash
# install.sh — install the autogap Claude Code skill
#
# Usage:
#   bash install.sh           install (or skip if already installed)
#   bash install.sh --update  reinstall, overwriting an existing installation
#   curl -fsSL https://raw.githubusercontent.com/micpet7514088/autogap/main/install.sh | bash

set -euo pipefail

REPO="https://github.com/micpet7514088/autogap"
RAW="https://raw.githubusercontent.com/micpet7514088/autogap/main"
SKILLS_DIR="${HOME}/.claude/skills"
SKILL_DIR="${SKILLS_DIR}/autogap"
SKILL_DST="${SKILL_DIR}/SKILL.md"

UPDATE=false
for arg in "$@"; do
  case "$arg" in
    --update) UPDATE=true ;;
    *) echo "Unknown argument: $arg" >&2; exit 1 ;;
  esac
done

# Detect whether we are running from the cloned repo or being piped.
# BASH_SOURCE[0] is empty (or "bash") when the script is piped via curl | bash.
SCRIPT_DIR=""
if [[ -n "${BASH_SOURCE[0]:-}" && "${BASH_SOURCE[0]}" != "bash" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

USE_SYMLINK=false
SKILL_SRC=""
if [[ -n "$SCRIPT_DIR" && -f "$SCRIPT_DIR/skills/autogap/SKILL.md" ]]; then
  SKILL_SRC="$SCRIPT_DIR/skills/autogap/SKILL.md"
  USE_SYMLINK=true
fi

# Check if already installed
if [[ -e "$SKILL_DST" || -L "$SKILL_DST" ]]; then
  if [[ "$UPDATE" == false ]]; then
    echo "autogap is already installed at $SKILL_DST"
    echo "Run with --update to reinstall."
    exit 0
  fi
  echo "Updating existing installation..."
  rm -f "$SKILL_DST"
fi

mkdir -p "$SKILL_DIR"

if [[ "$USE_SYMLINK" == true ]]; then
  ln -s "$SKILL_SRC" "$SKILL_DST"
  echo "autogap installed (symlinked — updates propagate automatically when you pull)."
  echo "Repo: $SCRIPT_DIR"
else
  if ! command -v curl &>/dev/null; then
    echo "Error: curl is required for remote install. Clone the repo and run bash install.sh instead." >&2
    echo "  git clone $REPO ~/autogap && bash ~/autogap/install.sh" >&2
    exit 1
  fi
  curl -fsSL "${RAW}/skills/autogap/SKILL.md" -o "$SKILL_DST"
  echo "autogap installed (downloaded — run install.sh --update after new releases)."
fi

echo ""
echo "Restart Claude Code. Then from any project directory:"
echo "  claude"
echo "  > /autogap"
