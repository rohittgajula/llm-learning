"""Run: python3 problems/rise-over-run/check.py"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from slope import is_straight, shrinking_slopes, slope


def close(a, b, tol=1e-9):
    return abs(a - b) < tol


# 1. slope
assert close(slope((1, 2), (3, 8)), 3), "the worked example from the lesson should be 3"
assert close(slope((3, 8), (1, 2)), 3), "point order shouldn't matter"
assert close(slope((0, 5), (4, 5)), 0), "a flat line has slope 0"
assert close(slope((0, 10), (5, 0)), -2), "a line going down has a negative slope"
try:
    slope((2, 1), (2, 9))
except ValueError:
    pass
else:
    raise AssertionError("a vertical line should raise ValueError")
print("ok  slope")

# 2. is_straight
assert is_straight([(0, 1), (1, 3), (2, 5), (10, 21)]), "y = 2x + 1 is straight"
assert not is_straight([(0, 0), (1, 1), (2, 4)]), "y = x^2 is not straight"
assert is_straight([(0, 0.1), (1, 0.2), (2, 0.3)]), "use a tolerance: floats aren't exact"
assert is_straight([]) and is_straight([(1, 1)]) and is_straight([(1, 1), (5, 0)])
print("ok  is_straight")

# 3. shrinking_slopes
hs = [1, 0.1, 0.01, 0.001, 0.0001]
got = shrinking_slopes(lambda x: 2 * x + 1, 3, hs)
assert len(got) == len(hs)
assert all(close(s, 2, 1e-6) for s in got), "a straight line has the same slope for every h"
curve = shrinking_slopes(lambda x: x * x, 3, hs)
assert close(curve[0], 7), "x^2 from x=3 to x=4: (16 - 9) / 1 = 7"
print("ok  shrinking_slopes")

print("\nf(x) = x^2 at x = 3")
print(f"{'h':>8}  {'slope':>10}")
for h, s in zip(hs, curve):
    print(f"{h:>8}  {s:>10.5f}")
print("\nAll checks pass. Now answer the 'Think about it' questions in the README.")
