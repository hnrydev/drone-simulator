#!/usr/bin/env bash
# Launch PX4 + Gazebo (Harmonic/GZ) after setup-full-sitl.sh has completed.

set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODEL="${1:-gz_x500_depth}"

cd "$ROOT/PX4-Autopilot"
exec make px4_sitl "$MODEL"
