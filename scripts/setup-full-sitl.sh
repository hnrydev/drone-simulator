#!/usr/bin/env bash
# Full PX4 SITL setup on Ubuntu/Debian-family (native laptop or WSL).
# Run from repo root or any directory: bash scripts/setup-full-sitl.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "==> Repo root: $ROOT"
echo "==> Updating git submodules (recursive)..."
git submodule update --init --recursive

PX4="$ROOT/PX4-Autopilot"
if [[ ! -f "$PX4/Makefile" ]]; then
  echo "ERROR: PX4-Autopilot missing. Clone with: git clone --recursive <this-repo>"
  exit 1
fi

echo "==> Installing OS dependencies + sim stack (PX4 ubuntu.sh). Needs sudo..."
sudo bash "$PX4/Tools/setup/ubuntu.sh"

echo "==> Building PX4 SITL (first build can take 20–60 minutes)..."
make -C "$PX4" px4_sitl

echo ""
echo "Done. Start Gazebo + quadcopter with:"
echo "  cd \"$PX4\""
echo "  make px4_sitl gz_x500_depth"
echo ""
echo "Headless (lighter on laptop GPU/CPU):"
echo "  HEADLESS=1 make px4_sitl gz_x500_depth"
