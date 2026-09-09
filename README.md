# u — Fedora system update shortcut

One command to update everything on Fedora:

- DNF packages and kernel drivers
- Flatpak applications
- Device firmware (via `fwupdmgr`)

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/priyanshuchawda/fedora-u/main/u -o ~/.local/bin/u
chmod +x ~/.local/bin/u
```

Or clone and copy manually:

```bash
git clone https://github.com/priyanshuchawda/fedora-u.git
cp fedora-u/u ~/.local/bin/u
chmod +x ~/.local/bin/u
```

Make sure `~/.local/bin` is on your `PATH`.

## Usage

```bash
u
```

Requires `sudo` for DNF and firmware updates. Keep the laptop on AC power while firmware is checked.

## What it runs

1. `sudo dnf upgrade --refresh --assumeyes`
2. `flatpak update --assumeyes` (if Flatpak is installed)
3. `sudo fwupdmgr refresh --force` and `sudo fwupdmgr update --assume-yes` (if `fwupdmgr` is available)
