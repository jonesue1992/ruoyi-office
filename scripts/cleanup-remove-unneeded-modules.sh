#!/usr/bin/env bash
set -euo pipefail

# cleanup-remove-unneeded-modules.sh
# Usage: run from repo root on branch 'simplify/oa-only':
#   ./scripts/cleanup-remove-unneeded-modules.sh
# This script will git rm the listed backend and frontend module directories if they exist,
# commit and push the removal. It's interactive and requires confirmation.

BRANCH_REQUIRED="simplify/oa-only"
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD || echo "")
if [ "$CURRENT_BRANCH" != "$BRANCH_REQUIRED" ]; then
  echo "Warning: current branch is '$CURRENT_BRANCH'. Recommended branch is '$BRANCH_REQUIRED'."
  read -p "Continue anyway? [y/N]: " confirm
  if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted by user."; exit 1
  fi
fi

MODULES=(
  "yudao-module-asset"
  "yudao-module-wms"
  "yudao-module-hrm"
  "yudao-module-member"
  "yudao-module-pay"
  "yudao-module-report"
  "yudao-module-mp"
  "yudao-module-mall"
  "yudao-module-crm"
  "yudao-module-erp"
  "yudao-module-ai"
  "yudao-module-iot"
)

FRONTS=(
  "yudao-ui/yudao-ui-mall-uniapp"
  # add other frontend module paths to remove if desired
)

echo "The following backend modules will be removed if present:"
for m in "${MODULES[@]}"; do echo "  - $m"; done

if [ ${#FRONTS[@]} -gt 0 ]; then
  echo "The following frontend paths will be removed if present:"
  for f in "${FRONTS[@]}"; do echo "  - $f"; done
fi

read -p "Proceed to remove these paths from the repository? This will run 'git rm -r' and commit. [y/N]: " proceed
if [[ "$proceed" != "y" && "$proceed" != "Y" ]]; then
  echo "No changes made. Exiting."; exit 0
fi

REMOVED=()
NOT_FOUND=()

for m in "${MODULES[@]}"; do
  if [ -d "$m" ]; then
    git rm -r "$m"
    REMOVED+=("$m")
  else
    NOT_FOUND+=("$m")
  fi
done

for f in "${FRONTS[@]}"; do
  if [ -d "$f" ]; then
    git rm -r "$f"
    REMOVED+=("$f")
  else
    NOT_FOUND+=("$f")
  fi
done

if [ ${#REMOVED[@]} -eq 0 ]; then
  echo "No paths removed. Nothing to commit."; exit 0
fi

# Final commit
COMMIT_MSG="chore: remove unnecessary modules (OA-only simplification)"

git commit -m "$COMMIT_MSG"

echo "About to push branch $(git rev-parse --abbrev-ref HEAD) to origin."
read -p "Push now? [y/N]: " pushnow
if [[ "$pushnow" == "y" || "$pushnow" == "Y" ]]; then
  git push origin $(git rev-parse --abbrev-ref HEAD)
  echo "Pushed."
else
  echo "Changes committed locally. Please push when ready."
fi

echo "Removed paths:"; for p in "${REMOVED[@]}"; do echo "  - $p"; done
if [ ${#NOT_FOUND[@]} -gt 0 ]; then
  echo "Not found (skipped):"; for p in "${NOT_FOUND[@]}"; do echo "  - $p"; done
fi
