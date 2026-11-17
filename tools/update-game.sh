#!/usr/bin/env bash
# Copies the current game file into the Android project.
# Usage: tools/update-game.sh [path/to/riftbound.html]
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${1:-$HERE/../game/dist/index.html}"
[ -f "$SRC" ] || SRC="$HERE/../dist/index.html"
cp "$SRC" "$HERE/app/src/main/assets/index.html"
echo "Copied $SRC -> app/src/main/assets/index.html"
