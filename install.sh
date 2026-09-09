#!/usr/bin/env bash
# Install u into ~/.local/bin. Run from repo root: ./install.sh

set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${INSTALL_DIR:-${HOME}/.local/bin}"
TARGET="${INSTALL_DIR}/u"

mkdir -p "$INSTALL_DIR"
cp "${REPO_ROOT}/u" "$TARGET"
chmod +x "$TARGET"

printf '%s\n' "Installed ${TARGET}"
printf '%s\n' "Run: u"
