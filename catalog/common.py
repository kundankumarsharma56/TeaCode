"""Small helpers shared by the problem definition files."""
import random


def rng(seed):
    return random.Random(seed)


def arr_case(a, *extra):
    """'n' line, array line, then one line per extra value."""
    return f"{len(a)}\n{' '.join(map(str, a))}\n" + "".join(f"{e}\n" for e in extra)


def check_arr(inp, nmin, nmax, lo, hi, extras=0):
    t = inp.split()
    n = int(t[0])
    assert nmin <= n <= nmax, f"n={n} outside [{nmin},{nmax}]"
    assert len(t) == 1 + n + extras, f"expected {1 + n + extras} tokens, got {len(t)}"
    for x in t[1:1 + n]:
        assert lo <= int(x) <= hi, f"value {x} outside [{lo},{hi}]"
    return n, [int(x) for x in t[1:1 + n]], t[1 + n:]


def lines_of(inp):
    return inp.rstrip("\n").split("\n")
