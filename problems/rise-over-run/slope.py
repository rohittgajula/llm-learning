"""Warm-up: slope = rise / run. Fill in the three functions."""


def slope(p1, p2):
    """Slope of the line through p1=(x1, y1) and p2=(x2, y2).

    Raise ValueError if the line is vertical (x1 == x2).
    """
    raise NotImplementedError


def is_straight(points):
    """True if every consecutive pair of points has the same slope (within 1e-9)."""
    raise NotImplementedError


def shrinking_slopes(f, x, hs):
    """For each h in hs, the slope between (x, f(x)) and (x + h, f(x + h))."""
    raise NotImplementedError
