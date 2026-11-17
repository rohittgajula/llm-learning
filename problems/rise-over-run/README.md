# Warm-up: slope = rise / run

*Optional. Slope is quiz-only in the plan, so this is a short warm-up before Derivative (~20 min). Plain Python, nothing to install.*

Slope answers one question: **for each unit the input moves, how much does the output move?** It's the same idea as requests/sec or cost per item.

## Task
Fill in the three functions in `slope.py`.

1. **`slope(p1, p2)`**: the slope of the line through two points `(x, y)`.
   - `slope((1, 2), (3, 8))` → `3.0`
   - The order of the points shouldn't matter.
   - A vertical line (same `x`) has no slope. Raise `ValueError`, the way an API returns a 400 for a request it can't answer, not a 500.

2. **`is_straight(points)`**: `True` if a list of points (sorted by `x`) is on one straight line, meaning every consecutive pair has the **same** slope.
   - Use a small tolerance (`abs(a - b) < 1e-9`), not `==`. Floats aren't exact.
   - Lists with 0, 1 or 2 points always count as straight.

3. **`shrinking_slopes(f, x, hs)`**: for each step `h` in `hs`, return the slope between `(x, f(x))` and `(x + h, f(x + h))`. Reuse `slope()`.

## Run the check
```bash
python3 problems/rise-over-run/check.py
```
When every check passes, it prints a table at the end.

## Think about it (you'll need this for Derivative)
Look at the table for `f(x) = x²` at `x = 3`. As `h` gets smaller:
- What number are the slopes getting close to?
- `x²` is **not** a straight line, so `is_straight` would say False. So which "slope" does a curve have at one point?

Write your guesses below, then take them into the Derivative lesson.

**My answers:**
-
