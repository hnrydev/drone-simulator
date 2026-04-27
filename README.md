# drone-simulator

Wrapper repo for PX4 + Gazebo SITL experiments. Upstream firmware lives in **`PX4-Autopilot`** as a Git submodule ([PX4/PX4-Autopilot](https://github.com/PX4/PX4-Autopilot)).

**New to Linux or PX4?** Follow **[START_HERE.md](START_HERE.md)** — step-by-step from zero on an Ubuntu ThinkPad (and a short note if you use Windows + WSL).

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

## One-shot setup (Ubuntu / WSL Ubuntu)

From the **repo root** after cloning with `--recursive`:

```bash
bash scripts/setup-full-sitl.sh
```

That updates submodules, runs PX4’s `ubuntu.sh` (deps + Gazebo stack), and builds **SITL** once. Then start the sim:

```bash
bash scripts/run-sim.sh gz_x500_depth
```

First full build can take **tens of minutes**. On Windows, read **[docs/WINDOWS-WSL.md](docs/WINDOWS-WSL.md)** so WSL stays healthy (clone under `~` in Linux, not only on `/mnt/c`).

## Build & run (manual)

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
├── README.md
├── START_HERE.md      ← beginner walkthrough (Ubuntu ThinkPad / WSL)
├── scripts/           ← setup-full-sitl.sh, run-sim.sh
├── docs/              ← WINDOWS-WSL.md, etc.
├── .gitmodules
└── PX4-Autopilot/     ← submodule → github.com/PX4/PX4-Autopilot
```

Updating the submodule pointer to a newer PX4 release is intentional; pull upstream changes inside `PX4-Autopilot` or bump the submodule commit from this repo.

## When you come back later

On the machine where you already cloned:

```bash
cd ~/drone-simulator    # or wherever you put this repo
git pull
git submodule update --init --recursive
```

- If setup **already finished** once (`setup-full-sitl.sh` completed successfully), skip straight to **`bash scripts/run-sim.sh gz_x500_depth`**.
- If you **never finished** setup or this is a **new PC**, run **`bash scripts/setup-full-sitl.sh`** again after the commands above (needs **~25 GB free disk** and time — see **[START_HERE.md](START_HERE.md)**).
