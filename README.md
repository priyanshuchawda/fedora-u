# u — Fedora system update shortcut

Typing `u` in the terminal runs a script that updates:

- DNF packages and kernel drivers
- Flatpak applications
- Device firmware (`fwupdmgr`)

Live copy lives at `~/.local/bin/u`. This repo holds the same script plus shell helpers to publish it.

## Repo scripts (run these, not raw git/gh)

| Script | Purpose |
|--------|---------|
| `./setup.sh` | First time: copy `u`, `git init`, create GitHub repo, push |
| `./push.sh` | Later: sync `u` from `~/.local/bin`, commit, push |
| `./install.sh` | Copy `u` into `~/.local/bin` |

### First push to GitHub

```bash
cd ~/fedora-u
chmod +x setup.sh push.sh install.sh u
./setup.sh
```

### Push changes later

```bash
cd ~/fedora-u
./push.sh "describe your change"
```

### Install on this machine

```bash
cd ~/fedora-u
./install.sh
```

## Usage

```bash
u
```

Requires `sudo` for DNF and firmware. Keep the laptop on AC power while firmware is checked.

## What `u` runs

Each step runs only if the tool is installed. Optional steps warn and continue on failure.

1. **Fedora:** `dnf upgrade`, then `dnf autoremove`
2. **Flatpak:** `flatpak update`, then remove unused runtimes
3. **Firmware:** `fwupdmgr refresh` + `fwupdmgr update`
4. **Reboot check:** `needs-restarting -r` (if `dnf-plugin-tr` is installed)
5. **Snap:** `snap refresh` (if installed)
6. **Containers:** `podman image prune` / `docker image prune` (if installed)
7. **Dev tools:** rustup, npm, pnpm, bun, uv, pipx, Flutter, Android SDK (if installed)

AppImages and other manual installs are skipped (no standard updater).

## Start over locally

```bash
cd ~/fedora-u
rm -rf .git
./setup.sh
```
