#!/usr/bin/env bash
# Push local changes to GitHub. Run from repo root: ./push.sh [message]

set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

REMOTE="${REMOTE:-origin}"
BRANCH="${BRANCH:-main}"
COMMIT_MSG="${1:-Update fedora-u}"

SOURCE_U="${HOME}/.local/bin/u"
TARGET_U="${REPO_ROOT}/u"

if [[ -f "$SOURCE_U" ]]; then
  cp "$SOURCE_U" "$TARGET_U"
fi

chmod +x "${REPO_ROOT}/u" "${REPO_ROOT}/setup.sh" "${REPO_ROOT}/push.sh"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not a git repo. Run ./setup.sh first." >&2
  exit 1
fi

if ! git remote get-url "$REMOTE" >/dev/null 2>&1; then
  echo "No remote '${REMOTE}'. Run ./setup.sh first." >&2
  exit 1
fi

git add -A

if ! git diff --cached --quiet; then
  git commit -m "$COMMIT_MSG"
fi

git push -u "$REMOTE" "$BRANCH"
printf '\n%s\n' "Pushed to $(git remote get-url "$REMOTE") (${BRANCH})"
