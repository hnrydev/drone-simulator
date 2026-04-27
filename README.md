# drone-simulator

Wrapper repo for PX4 + Gazebo SITL experiments. Upstream firmware lives in **`PX4-Autopilot`** as a Git submodule ([PX4/PX4-Autopilot](https://github.com/PX4/PX4-Autopilot)).

## Clone

Always use **`--recursive`** so nested submodules (sim assets, mavlink, NuttX, etc.) are present:

```bash
git clone --recursive https://github.com/hnrydev/drone-simulator.git
cd drone-simulator
```

If you already cloned without `--recursive`:

```bash
git submodule update --init --recursive
```

## Build & run (Ubuntu)

From `PX4-Autopilot`:

```bash
cd PX4-Autopilot
bash ./Tools/setup/ubuntu.sh    # once per machine
make px4_sitl gz_x500_depth      # or gz_x500
```

Use **QGroundControl** alongside for arming/takeoff. Stop with **Ctrl+C** in the PX4 terminal.

### Laptop / headless

```bash
HEADLESS=1 make px4_sitl gz_x500_depth
```

## Folder layout

```
drone-simulator/
├── README.md          ← this file
├── .gitmodules
└── PX4-Autopilot/     ← submodule → github.com/PX4/PX4-Autopilot
```

Updating the submodule pointer to a newer PX4 release is intentional; pull upstream changes inside `PX4-Autopilot` or bump the submodule commit from this repo.
