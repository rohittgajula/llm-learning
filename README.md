# llm-learning

Learning how LLMs work (math basics to a tiny GPT on a book) and how to build production AI features on top of them, aiming at an Applied AI / LLM Engineer role.

- [ROADMAP.md](ROADMAP.md): the 4-month plan, Part A (the LearnHarness map of LLM internals) and Part B (the applied AI engineer track)
- [PROGRESS.md](PROGRESS.md): every concept, how it's practised (Quiz / Problem / BUILD / project) and its status
- [CLAUDE.md](CLAUDE.md): context Claude Code loads automatically when opened in this folder
- `problems/`, `builds/`, `projects/`: practice code (small problems, Part A BUILDs, Part B projects); `data/`: shared inputs
- `notes/`: LearnHarness exports (`notes/llms.md` is the main session). Never edit these by hand.
- `scripts/`: the auto-sync job
- [SETUP-OTHER-LAPTOP.md](SETUP-OTHER-LAPTOP.md): instructions to give Claude on another laptop

## Daily routine
```
LearnHarness lesson ──► export to notes/ ──► Claude Code practice ──► "Update progress and push."
  (concept + quiz)       (auto-synced)        (problem / BUILD / project)
```

1. **Learn** a concept in LearnHarness and answer its quiz.
2. **Check the practice type** for that concept in [PROGRESS.md](PROGRESS.md):
   - *Quiz*: nothing to build. Go on to the next lesson.
   - *Problem*, *BUILD*, *P1* or *P2*: go to step 3.
3. **Export** the session (see [Exporting from LearnHarness](#exporting-from-learnharness)). Claude Code only knows what you just learned through this file.
4. **Open Claude Code in the repo**, either in the desktop app (pick the `~/llm-learning` folder) or in a terminal:
   ```bash
   cd ~/llm-learning && claude
   ```
   Don't use a Claude Code session opened in another project; it won't load this repo's `CLAUDE.md`.
5. **Practise:** say `Let's practise what I just learned.` Claude writes only the task (`README.md` in the problem's folder). **You type all the code yourself.** When you ask for help, Claude reads your code and answers in chat; it never edits your files.
6. **Finish:** say `Update progress and push.` Claude updates `PROGRESS.md` and commits and pushes your code as it is. (Only `notes/` syncs by itself; practice code doesn't.)

### What to say in Claude Code
| When | Say |
|---|---|
| After a LearnHarness lesson (export first) | `Let's practise what I just learned.` |
| Unsure what's next | `Where am I and what's next?` |
| Starting a BUILD or a project step | `Start the line-fit BUILD.` / `Next step of P1.` |
| Stuck on a problem | `Give me a hint.` / `Review my code in problems/derivatives.` |
| Want the full answer | `Show me the solution.` (shown in chat, never written into your files) |
| Done for the day | `Update progress and push.` |

## Exporting from LearnHarness
1. Use LearnHarness's export for the LLMs session.
2. Save it into **Desktop → llm-learning → notes** with the name `llms.md` (LearnHarness's default name; `LLMs.md` is the same file to macOS).
3. If asked, choose **Replace**. Don't keep both: a second file like `llms (1).md` is not an overwrite.
   - Saved it in the `llm-learning` folder itself by mistake? The sync job moves `llms.md` into `notes/` for you, as long as it's newer than the copy in `notes/`.
4. Wait for the **"Notes saved to GitHub"** notification (a few seconds; up to 5 minutes if you were offline).
5. Not sure it synced? Check:
   ```bash
   git -C ~/llm-learning status -sb
   ```
   `## main...origin/main` with nothing listed below it means it's on GitHub. The sync log is `~/Library/Logs/llm-learning-autopush.log`.

## Switching laptops
**On the laptop you're leaving**
1. Export from LearnHarness (steps above) and wait for "Notes saved to GitHub".
2. If you practised in Claude Code, make sure you said `Update progress and push.`

**On the laptop you're moving to**
1. Get the latest files. The sync job pulls within 5 minutes; to get them now:
   ```bash
   git -C ~/llm-learning pull
   ```
2. Copy the resume prompt:
   ```bash
   pbcopy < ~/llm-learning/RESUME-PROMPT.txt
   ```
3. In LearnHarness, start a session, **attach `notes/llms.md`** and paste the prompt. Always attach the file; without it LearnHarness has nothing to resume from.
4. Check its first reply: a word-for-word replay of earlier lessons, a 3-line recap and a check question, with the map from `ROADMAP.md`. If it summarised instead, reply `you summarised, reproduce it word for word`.
5. For practice, open Claude Code in `~/llm-learning` there and say `Where am I and what's next?`

New laptop with no repo yet: follow [SETUP-OTHER-LAPTOP.md](SETUP-OTHER-LAPTOP.md).

## How syncing works
Export from LearnHarness into **Desktop → llm-learning → notes**, overwriting `llms.md`. A background job then:

1. Waits until the export has finished writing (no change for 3 seconds).
2. Commits it **before** pulling anything, so nothing on this laptop can be overwritten.
3. Pulls the other laptop's exports.
4. Pushes, and shows a "Notes saved to GitHub" notification.

It runs whenever `notes/` or the repo folder changes, every 5 minutes, and at login, so it also keeps this laptop up to date.

- **Offline:** the export is committed locally and pushed on the next run once you're back online.
- **Both laptops changed `llms.md`:** the GitHub version stays as `llms.md` and this laptop's version is saved beside it as `llms.conflict-<laptop>-<time>.md`, with a notification. Nothing is lost; you pick which to keep.
- **Export saved as `llms (1).md`:** that's a second file, not an overwrite. It still syncs, but delete the old one or rename so there's one main file.
- **Log:** `~/Library/Logs/llm-learning-autopush.log`

The real folder is `~/llm-learning`; the Desktop item is a shortcut to it (macOS blocks background jobs from reading Desktop directly).
