# Setting up another laptop (instructions for Claude)

Give everything in the box below to Claude Code on the new laptop.

```text
Set up my LLM-learning repo on this Mac so it stays in sync with my other laptop. Follow these steps exactly and stop to ask me if anything doesn't match.

Background: I'm a backend developer learning how LLMs work, using an app called LearnHarness. I export my LearnHarness session (a markdown file) into the notes/ folder of the GitHub repo https://github.com/rohittgajula/lms-learning, and a launchd job commits and pushes it automatically. The repo also has ROADMAP.md (my course map) and README.md (how syncing works).

1. Check GitHub access: run `git ls-remote https://github.com/rohittgajula/lms-learning.git`. If it fails or asks for a login, stop and ask me to sign in myself (for example `gh auth login`, then `gh auth setup-git`). Never type passwords or tokens yourself.

2. Clone to ~/lms-learning (NOT inside ~/Desktop: macOS blocks background jobs from reading Desktop). If ~/lms-learning already exists, don't overwrite it: show me what's there and ask. If ~/Desktop/lms-learning already exists as a real folder (not a symlink), ask me before touching it.

3. Read scripts/install-autopush.sh and scripts/auto-push.sh so you know what they do, then run `bash ~/lms-learning/scripts/install-autopush.sh`. It installs a launchd agent (com.rohit.lms-learning.autopush) that syncs notes/ whenever it changes, every 5 minutes and at login, and puts a shortcut at ~/Desktop/lms-learning.

4. Verify, without creating test commits:
   - `ls -la ~/Desktop/lms-learning` shows a symlink to ~/lms-learning
   - `launchctl print gui/$(id -u)/com.rohit.lms-learning.autopush | grep "last exit"` shows 0 (wait ~10 seconds after installing)
   - `git -C ~/lms-learning status` is clean and up to date with origin/main
   - ~/Library/Logs/lms-learning-autopush.log has no errors
   If the exit code isn't 0, read the log and tell me what went wrong.

5. Read README.md, ROADMAP.md and the newest file in notes/, then tell me in a few lines where I am in the course (last lesson taught, any question pending) and give me the "resume" prompt from README.md to paste into LearnHarness.

Rules for this repo:
- Never edit, rename or delete anything in notes/. Those files are exact LearnHarness exports; the sync depends on them being untouched.
- Never force-push, rewrite history, or run git reset --hard.
- If you see a file named *.conflict-*.md in notes/, both laptops changed the same export. Don't delete it; tell me and let me decide which one to keep.
```
