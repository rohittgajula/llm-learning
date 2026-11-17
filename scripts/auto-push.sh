#!/bin/bash
# Syncs notes/ with GitHub. Run by launchd when notes/ changes, every 5 minutes, and at login.
# Never throws away an export: local changes are committed before anything is pulled, a failed
# push is retried on the next run, and if both laptops changed the same file the local copy is
# kept next to it as <name>.conflict-<laptop>-<time>.md with a notification.
REPO="${LLM_REPO:-$(cd "$(dirname "$0")/.." && pwd)}"   # the repo this script lives in
LOG="${LLM_LOG:-$HOME/Library/Logs/llm-learning-autopush.log}"
LOCK="${TMPDIR:-/tmp}/llm-learning-autopush.$(echo "$REPO" | md5).lock"

exec >>"$LOG" 2>&1
cd "$REPO" || exit 1
mkdir "$LOCK" 2>/dev/null || exit 0
trap 'rmdir "$LOCK"' EXIT

log() { echo "$(date '+%Y-%m-%d %H:%M:%S') $*"; }
notify() { [ -n "$LLM_QUIET" ] || osascript -e "display notification \"$1\" with title \"llm-learning\"" >/dev/null 2>&1; }
laptop=$(scutil --get LocalHostName 2>/dev/null || hostname -s)

# Wait until the export has stopped changing: same sizes and times 3 seconds apart (up to 60s).
snapshot() { find notes . -maxdepth 1 -type f \( -path 'notes/*' -o -iname 'llms.md' \) -exec stat -f '%N %z %m' {} + 2>/dev/null | sort; }
prev=$(snapshot)
for _ in $(seq 1 20); do
  sleep "${LLM_SETTLE:-3}"
  cur=$(snapshot)
  [ "$cur" = "$prev" ] && break
  prev=$cur
done

# 0. An export saved in the repo folder instead of notes/ gets moved in. LearnHarness names it
#    llms.md; macOS ignores case, so LLMs.md matches too. An older copy is left alone and reported.
stray=$(find . -maxdepth 1 -type f -iname 'llms.md' | head -1)
if [ -n "$stray" ] && ! git ls-files --error-unmatch "$stray" >/dev/null 2>&1; then
  if [ ! -e notes/llms.md ] || ! [ notes/llms.md -nt "$stray" ]; then
    mv -f "$stray" notes/llms.md
    log "moved ${stray#./} into notes/llms.md (the export was saved outside notes/)"
  else
    log "left ${stray#./} in the repo folder: it is older than notes/llms.md"
    notify "An older llms.md is in the repo folder, not in notes. Check it."
  fi
fi

# 1. Commit local exports first, so a pull can never overwrite them.
if [ -n "$(git status --porcelain -- notes)" ]; then
  git add -A notes
  git commit -q -m "Update notes from $laptop ($(date '+%Y-%m-%d %H:%M'))"
  log "committed: $(git diff --stat HEAD~1 HEAD | tail -1)"
fi

# 2. Bring in the other laptop's exports. Offline is fine: everything retries next run.
if ! git fetch -q origin; then
  log "fetch failed (offline?), will retry"
  exit 0
fi

if ! git merge -q --no-edit origin/main; then
  conflicted=$(git diff --name-only --diff-filter=U)
  if echo "$conflicted" | grep -qv '^notes/'; then
    git merge --abort
    log "merge conflict outside notes/, left for you to fix: $conflicted"
    notify "Sync stopped: conflict outside notes. Check the log."
    exit 1
  fi
  stamp=$(date '+%Y%m%d-%H%M%S')
  for f in $conflicted; do
    copy="${f%.*}.conflict-$laptop-$stamp.${f##*.}"
    git show ":2:$f" >"$copy"          # this laptop's version
    git checkout --theirs -- "$f"      # the version already on GitHub
    git add "$f" "$copy"
    log "conflict in $f: GitHub version kept, this laptop's version saved as $copy"
  done
  git commit -q --no-edit
  notify "Both laptops changed the notes. Nothing lost: this laptop's copy is saved as a .conflict file."
fi

# 3. Push anything not on GitHub yet, including commits from earlier failed runs.
if [ "$(git rev-list --count origin/main..HEAD)" -gt 0 ]; then
  if git push -q origin HEAD:main; then
    log "pushed $(git rev-parse --short HEAD)"
    notify "Notes saved to GitHub"
  else
    log "push failed, will retry"
    notify "Push failed, will retry in 5 minutes. Check the log."
  fi
fi
