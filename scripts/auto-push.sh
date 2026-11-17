#!/bin/bash
# Commits and pushes anything new in notes/. Run by launchd whenever notes/ changes.
REPO="$HOME/lms-learning"
LOG="$HOME/Library/Logs/lms-learning-autopush.log"

exec >>"$LOG" 2>&1
cd "$REPO" || exit 1

# Let the export finish writing before committing.
sleep 5

if [ -z "$(git status --porcelain -- notes)" ]; then
  exit 0
fi

echo "--- $(date '+%Y-%m-%d %H:%M:%S')"
git pull --rebase --autostash -q origin main
git add notes
git commit -q -m "Update notes ($(date '+%Y-%m-%d %H:%M'))"
git push -q origin main && echo "pushed"
