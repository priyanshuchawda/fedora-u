#!/usr/bin/env bash
# Push this repo to GitHub. Run from the repo root.

set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

REMOTE="${1:-origin}"
BRANCH="${2:-main}"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git init -b "$BRANCH"
fi

if ! git remote get-url "$REMOTE" >/dev/null 2>&1; then
  echo "No remote '$REMOTE'. Create the repo first, then:"
  echo "  git remote add $REMOTE git@github.com:priyanshuchawda/fedora-u.git"
  exit 1
fi

git add -A
if ! git diff --cached --quiet; then
  git commit -m "${3:-Update fedora-u}"
fi

git push -u "$REMOTE" "$BRANCH"
echo "Pushed to $(git remote get-url "$REMOTE") ($BRANCH)"
