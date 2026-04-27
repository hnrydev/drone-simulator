# Start here — drone simulator on your ThinkPad

This guide assumes your ThinkPad is running **Ubuntu Linux** (a common setup on ThinkPads). If your laptop runs **Windows only**, skip to the bottom of this page first.

---

## What you are installing (in plain English)

| Piece | What it is |
|--------|------------|
| **This project** | A small wrapper around the real flight software (**PX4**) and a 3D simulator (**Gazebo**). |
| **“SITL”** | “Software in the loop” — the drone exists only on your computer for practice. |
| **Your role** | Copy-paste commands into **Terminal**, wait while things download and build, then open the simulator window. |

You do **not** need to understand programming to follow this.

---

## Before you start

1. **Power** — Plug the laptop into wall power for the first setup. The first build can take **30–90 minutes** and uses the CPU heavily.
2. **Disk space** — Leave at least **25 GB** free (downloads + build files).
3. **Internet** — Use stable Wi‑Fi or Ethernet; the setup downloads several gigabytes.
4. **Patience** — Long waits and lots of text scrolling are normal. Only worry if you see a clear **error:** line at the end.

---

## Step 1 — Open Terminal

- Press the **Windows / Super** key (often between Ctrl and Alt).
- Type **Terminal**.
- Open the **Terminal** app.

You should see a window with a prompt like `yourname@yourcomputer:~$`.

---

## Step 2 — Install Git (one-time)

Copy this **whole block**, paste into Terminal, press **Enter**, type your password when asked (nothing will appear while typing — that’s normal):

```bash
sudo apt update
sudo apt install -y git
```

Wait until it finishes and you get the prompt again.

---

## Step 3 — Download this project

Copy-paste **one line at a time**, pressing **Enter** after each:

```bash
cd ~
git clone --recursive https://github.com/hnrydev/drone-simulator.git
cd drone-simulator
```

The first command goes to your **home** folder.  
The second downloads the project (this can take **several minutes**).  
The third enters the project folder.

---

## Step 4 — Run the automatic setup (long step)

Still inside `drone-simulator`, run:

```bash
bash scripts/setup-full-sitl.sh
```

What happens:

1. It finishes downloading missing pieces of the drone software (**submodules**).
2. It installs system packages and simulation tools (**you may need to type your password again**).
3. It **builds** the simulator — **expect 30–90 minutes** on a laptop the first time.

**Do not close Terminal** during this unless it has clearly stopped with an error.

When it finishes successfully, it will print a short “Done” style message and suggest how to **start** the sim.

---

## Step 5 — Start the drone in the simulator

```bash
bash scripts/run-sim.sh gz_x500_depth
```

After a short wait you should get a **3D window** (Gazebo) with a quadcopter.  
A separate Terminal stream will show flight-stack logs — **leave that Terminal open** while you fly.

**To stop everything:** click the Terminal window that is running the sim and press **Ctrl+C** once, wait a few seconds.

---

## Step 6 — (Optional) Use a ground station app

For a graphical way to arm and take off (easier than keyboard-only):

1. Install **QGroundControl** on Ubuntu using the official instructions:  
   [Download and install QGroundControl](https://docs.qgroundcontrol.com/master/en/getting_started/download_and_install.html)
2. Start QGroundControl **after** the simulator is running. It usually connects automatically.

---

## If the laptop gets hot or loud

That’s normal during build. For **flying only**, you can run without the heavy 3D window:

```bash
cd ~/drone-simulator/PX4-Autopilot
HEADLESS=1 make px4_sitl gz_x500_depth
```

---

## If something goes wrong

1. **Copy the last 20–30 lines** from Terminal (including any line starting with `E:` or `error`).
2. Search the web for that message plus “PX4” or “Ubuntu”, or ask someone technical with that paste.

Common fixes:

- **“Permission denied” / sudo** — Run the command again; make sure you use `sudo` where the guide says so.
- **Out of disk space** — Free space, then run Step 4 again from `cd ~/drone-simulator`.
- **Clone failed** — Check internet; run `cd ~/drone-simulator && git submodule update --init --recursive` then run Step 4 again.

---

## If your ThinkPad runs Windows (not Ubuntu)

PX4 + Gazebo expect a **Linux** environment. On Windows you typically use **WSL2 + Ubuntu**:

1. Follow Microsoft’s guide to install **WSL** and an **Ubuntu** app from the Microsoft Store.
2. Open **Ubuntu** from the Start menu (not PowerShell).
3. Follow **this same guide** from Step 2 onward **inside that Ubuntu window**.

Extra tips (clone location, fixing a broken install): see **[docs/WINDOWS-WSL.md](docs/WINDOWS-WSL.md)**.

---

## Coming back another day

Open Terminal and run:

```bash
cd ~/drone-simulator
git pull
git submodule update --init --recursive
```

If you **already finished** Step 4 before, you can usually go straight to **Step 5** (`bash scripts/run-sim.sh`). If you **never finished** setup or you’re on a **new machine**, run Step 4 again (`bash scripts/setup-full-sitl.sh`) after the commands above.

---

## Quick command summary (after everything is installed once)

| Goal | Command |
|------|---------|
| Go to project | `cd ~/drone-simulator` |
| Start sim | `bash scripts/run-sim.sh gz_x500_depth` |
| Stop sim | **Ctrl+C** in the Terminal that is running it |

You’re set. The hard part is **only the first long setup**; after that, starting the sim is usually two commands.
