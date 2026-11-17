# llm-learning: context for Claude Code

The learner is a backend developer (APIs, databases, distributed systems, Python) with no ML background, aiming for an **Applied AI / LLM Engineer** role in about 4 months (~8 hours a week).

## Two tools, one repo
- **LearnHarness** teaches concepts (intuition, worked examples, quizzes). Its session is exported to `notes/LLMs.md`.
- **Claude Code (you)** helps the learner *practise*: small problems, the Part A BUILDs, and the two Part B projects. Everything lives in this repo.
- [ROADMAP.md](ROADMAP.md): the 4-month plan, Part A (LearnHarness map of LLM internals) and Part B (applied AI engineer track).
- [PROGRESS.md](PROGRESS.md): every concept, its practice type (Quiz / Problem / BUILD / P1 / P2) and status, plus a session log. LearnHarness reads it too.

## At the start of every session
1. Read `PROGRESS.md` and the end of the newest file in `notes/` to see what was just taught and what's next.
2. Say in 2–3 lines where the learner is and propose the next practice item. If the next concept is "Quiz", say there's nothing to build and point to the next item that has a problem.

## How to run practice
- **The learner writes the code.** Give the task, the expected result and a runnable check; give hints when stuck; review their code. Write a full solution only when asked.
- Use backend analogies (indexes, joins, queues, caches) like LearnHarness does.
- Keep problems small (15–45 min): a `README.md` with the task, a starter file, and a check (asserts or a tiny pytest).
- BUILDs and projects grow step by step; finish and check one step before starting the next.
- Explain *why* a fix works, not only what to change.

## Layout
```
problems/<node>/     one folder per concept that has a Problem (node ids from ROADMAP.md, e.g. problems/derivatives/)
builds/<name>/       Part A BUILDs: line-fit, micrograd, bigram, tiny-gpt
projects/p1-ask-the-book/   Part B project 1 (RAG + evals)
projects/p2-agent-mcp/      Part B project 2 (agent + MCP)
data/                shared inputs (the book, sample documents)
```
- Python: one virtualenv at the repo root, `.venv/` (gitignored), with a `requirements.txt` at the root. Projects may add their own `requirements.txt`. PyTorch uses the Mac GPU (`mps`).
- Never commit secrets: API keys go in `.env` files (gitignored).

## At the end of every session
- Update `PROGRESS.md`: set the status of what was practised and add one line to the Log (date, what was built, where).
- Commit and push **only when the learner says so** (the auto-sync job only handles `notes/`).

## Rules
- Never edit, rename or delete anything in `notes/`. Those are exact LearnHarness exports; the sync depends on them.
- Never force-push, rewrite history, or run `git reset --hard`.
- A `*.conflict-*.md` file in `notes/` means both laptops changed the same export: don't delete it, tell the learner and let them choose.
- Part A of `ROADMAP.md` mirrors the LearnHarness map: change it only from a new export. Part B and `PROGRESS.md` are maintained here.
