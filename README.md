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

1. `sudo dnf upgrade --refresh --assumeyes`
2. `flatpak update --assumeyes` (if Flatpak is installed)
3. `sudo fwupdmgr refresh --force` and `sudo fwupdmgr update --assume-yes` (if available)

## Start over locally

```bash
cd ~/fedora-u
rm -rf .git
./setup.sh
```
