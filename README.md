# lms-learning

Learning how LLMs work, from math basics to building a tiny GPT on a book.

- [ROADMAP.md](ROADMAP.md): the map, how topics connect, and what each one teaches
- `notes/`: LearnHarness exports (`notes/LLMs.md` is the main session)
- `scripts/`: auto-push on export

## How syncing works
Export from LearnHarness into `notes/` (overwrite `LLMs.md`). Within a few seconds the change is committed and pushed to GitHub automatically.

## Setting up the other laptop
```bash
git clone https://github.com/rohittgajula/lms-learning.git ~/Desktop/lms-learning
bash ~/Desktop/lms-learning/scripts/install-autopush.sh
```
Before studying there, run `git -C ~/Desktop/lms-learning pull` to get the latest export.

## Resuming in LearnHarness on another laptop
Attach `notes/LLMs.md` and send:

```text
I'm continuing an existing learning session from another device. The attached file is the full transcript so far: the learner profile, the probe results, the roadmap, and the lessons completed.

Do not restart or re-probe me. Rebuild the same roadmap from the transcript, mark everything already taught as done, and continue exactly where the last lesson stopped. Begin with a 3-line recap of the last lesson and one quick check question, then carry on with the next step.
```
