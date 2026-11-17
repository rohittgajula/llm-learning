# lms-learning

Learning how LLMs work (math basics to a tiny GPT on a book) and how to build production AI features on top of them, aiming at an Applied AI / LLM Engineer role.

- [ROADMAP.md](ROADMAP.md): the 4-month plan, Part A (the LearnHarness map of LLM internals) and Part B (the applied AI engineer track)
- [PROGRESS.md](PROGRESS.md): every concept, how it's practised (Quiz / Problem / BUILD / project) and its status
- [CLAUDE.md](CLAUDE.md): context Claude Code loads automatically when opened in this folder
- `problems/`, `builds/`, `projects/`: practice code (small problems, Part A BUILDs, Part B projects); `data/`: shared inputs
- `notes/`: LearnHarness exports (`notes/LLMs.md` is the main session). Never edit these by hand.
- `scripts/`: the auto-sync job
- [SETUP-OTHER-LAPTOP.md](SETUP-OTHER-LAPTOP.md): instructions to give Claude on another laptop

## How learning works
LearnHarness teaches a concept. Then open Claude Code in `~/lms-learning` and say "let's practise what I just learned": it reads `PROGRESS.md` and the latest export, and gives you the problem, BUILD step or project step for it. Concepts marked *Quiz* in `PROGRESS.md` have nothing to build.

Practice code is **not** synced automatically (only `notes/` is). Ask Claude Code to commit and push at the end of a practice session.

## How syncing works
Export from LearnHarness into **Desktop → lms-learning → notes**, overwriting `LLMs.md`. A background job then:

1. Waits until the export has finished writing (no change for 3 seconds).
2. Commits it **before** pulling anything, so nothing on this laptop can be overwritten.
3. Pulls the other laptop's exports.
4. Pushes, and shows a "Notes saved to GitHub" notification.

It runs whenever `notes/` changes, every 5 minutes, and at login, so it also keeps this laptop up to date.

- **Offline:** the export is committed locally and pushed on the next run once you're back online.
- **Both laptops changed `LLMs.md`:** the GitHub version stays as `LLMs.md` and this laptop's version is saved beside it as `LLMs.conflict-<laptop>-<time>.md`, with a notification. Nothing is lost; you pick which to keep.
- **Export saved as `LLMs (1).md`:** that's a second file, not an overwrite. It still syncs, but delete the old one or rename so there's one main file.
- **Log:** `~/Library/Logs/lms-learning-autopush.log`

The real folder is `~/lms-learning`; the Desktop item is a shortcut to it (macOS blocks background jobs from reading Desktop directly).

## Switching laptops
1. On the laptop you're leaving, export from LearnHarness and wait for the "Notes saved to GitHub" notification.
2. On the other laptop the job pulls within 5 minutes. To get it right away: `git -C ~/lms-learning pull`
3. In LearnHarness there, attach `notes/LLMs.md` and send the prompt in [RESUME-PROMPT.txt](RESUME-PROMPT.txt). To copy it: `pbcopy < ~/lms-learning/RESUME-PROMPT.txt`
