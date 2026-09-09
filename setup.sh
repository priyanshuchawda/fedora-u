#!/usr/bin/env bash
# First-time setup: copy u, init git, create GitHub repo, push.
# Run from repo root: ./setup.sh

set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

REPO_NAME="${REPO_NAME:-fedora-u}"
GITHUB_USER="${GITHUB_USER:-priyanshuchawda}"
BRANCH="${BRANCH:-main}"
REMOTE="${REMOTE:-origin}"
COMMIT_MSG="${COMMIT_MSG:-Add Fedora one-shot update script (u).}"

SOURCE_U="${HOME}/.local/bin/u"
TARGET_U="${REPO_ROOT}/u"

if [[ -f "$SOURCE_U" ]]; then
  cp "$SOURCE_U" "$TARGET_U"
  echo "Copied ${SOURCE_U} -> ${TARGET_U}"
fi

chmod +x "${REPO_ROOT}/u" "${REPO_ROOT}/setup.sh" "${REPO_ROOT}/push.sh"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI is required. Install: sudo dnf install gh" >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub CLI is not signed in. Run: gh auth login" >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git init -b "$BRANCH"
fi

git add -A

if ! git diff --cached --quiet; then
  git commit -m "$COMMIT_MSG"
fi

if ! git remote get-url "$REMOTE" >/dev/null 2>&1; then
  gh repo create "$REPO_NAME" \
    --public \
    --source=. \
    --remote="$REMOTE" \
    --description "One command to update Fedora packages, Flatpak apps, and firmware" \
    --push
else
  git push -u "$REMOTE" "$BRANCH"
fi

printf '\n%s\n' "Done: https://github.com/${GITHUB_USER}/${REPO_NAME}"
