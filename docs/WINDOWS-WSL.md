# Windows + WSL: make PX4 simulation reliable

PX4 + Gazebo are **Linux workflows**. On Windows you run them inside **WSL2** (Ubuntu recommended). Cursor cannot repair a broken WSL disk from chat; these steps fix the usual failures.

## 1. Install or repair Ubuntu (WSL2)

- Install **Ubuntu** from the Microsoft Store, **or**:  
  `wsl --install -d Ubuntu`
- Prefer **WSL2** (default on current Windows).

## 2. Put the repo on the Linux filesystem (important)

Do **not** build only from `C:\...` mounted as `/mnt/c` if you hit slow builds or strange errors.

Inside Ubuntu:

```bash
cd ~
git clone --recursive https://github.com/hnrydev/drone-simulator.git
cd drone-simulator
bash scripts/setup-full-sitl.sh
bash scripts/run-sim.sh gz_x500_depth
```

## 3. If `apt` / WSL breaks (read-only filesystem, dpkg errors)

1. Close terminals using WSL.
2. **PowerShell (Admin):** `wsl --shutdown`
3. Reboot PC if problems persist.
4. Start Ubuntu again and run `sudo apt-get update && sudo apt-get -f install`

If it still fails, **back up your files**, then reset only that distro:

```powershell
wsl --unregister Ubuntu
```

Reinstall Ubuntu from the Store, then clone `~/drone-simulator` again and rerun `scripts/setup-full-sitl.sh`.

## 4. GUI (Gazebo window)

Use **Windows 11 + WSLg**, or an **X server** on older setups. Without a display, use:

```bash
HEADLESS=1 bash scripts/run-sim.sh gz_x500_depth
```

## 5. One download that always helps

**[QGroundControl](https://docs.qgroundcontrol.com/master/en/getting_started/download_and_install.html)** — install on Windows; it connects to SITL over UDP for arm/takeoff.
