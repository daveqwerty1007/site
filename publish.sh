#!/usr/bin/env bash
# One-time setup: create the repo, push, and turn on GitHub Pages.
# Requires the GitHub CLI, authenticated as you:  gh auth login
set -euo pipefail

REPO="${1:-scotiabank-offers}"
USER="$(gh api user --jq .login)"

echo "==> Creating $USER/$REPO (public — required for Pages on a free plan)"
gh repo create "$REPO" --public --source=. --remote=origin --push

echo "==> Enabling GitHub Pages from the main branch"
gh api -X POST "repos/$USER/$REPO/pages" \
  -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
  || echo "    (Pages may already be enabled — check Settings > Pages)"

echo
echo "Done. Your sheet will be live in a minute or two at:"
echo "    https://$USER.github.io/$REPO/"
