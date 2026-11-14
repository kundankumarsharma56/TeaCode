"""New problems, batch 1: strings, hashing, prefix sums, sliding window, two pointers, binary search."""
from lib import Problem
from common import rng, arr_case, check_arr, lines_of

PROBLEMS = []
add = PROBLEMS.append
B = 10 ** 9


def rstr(seed, n, alphabet="abcdefghijklmnopqrstuvwxyz"):
    r = rng(seed)
    return "".join(r.choice(alphabet) for _ in range(n))


def ok(cond, msg="constraint violated"):
    if not cond:
        raise AssertionError(msg)


# ---------------------------------------------------------------------------------------------------------------
def _valid_rot(inp):
    ls = lines_of(inp)
    ok(len(ls) == 2)
    for s in ls:
        ok(1 <= len(s) <= 100000 and s.isascii() and s.islower() and s.isalpha(), "string out of range")


_big = rstr(101, 100000)
_big_rot = _big[12345:] + _big[:12345]
_big_bad = list(_big_rot)
_big_bad[0], _big_bad[-1] = _big_bad[-1], _big_bad[0] if _big_bad[0] != _big_bad[-1] else "z"
_big_bad = "".join(_big_bad)
if _big_bad == _big_rot:
    _big_bad = _big_rot[:-1] + ("a" if _big_rot[-1] != "a" else "b")

add(Problem(
    slug="check-string-rotation", title="Check if Strings Are Rotations of Each Other", difficulty="EASY", tags=["Strings"],
    story="Two strings `s1` and `s2` are *rotations* of each other if `s2` can be obtained from `s1` by moving some number of characters (possibly zero) from the front of `s1` to its back, **without changing the order of the characters**. For example `cdab` is a rotation of `abcd` (move `ab` to the back).\n\nDecide whether `s2` is a rotation of `s1`. Any number of positions may be rotated, not just a fixed one.",
    input_fmt="The first line contains the string `s1`. The second line contains the string `s2`.",
    output_fmt="Print `true` if `s2` is a rotation of `s1`, otherwise print `false`.",
    constraints=["`1 <= |s1|, |s2| <= 100000`", "Both strings consist of lowercase English letters."],
    examples=[
        ("abcd\ncdab", "true", "Rotating `abcd` left by two positions moves `ab` to the back and gives `cdab`."),
        ("aab\naba", "true", "A single left rotation of `aab` gives `aba`."),
        ("abcd\nacbd", "false", "Both strings contain the same letters, but `acbd` cannot be produced by rotating `abcd`: rotation never changes the cyclic order of the letters."),
        ("abc\nabcd", "false", "The lengths differ, so one cannot be a rotation of the other."),
    ],
    hidden=lambda: ["a\na", "a\nb", "ab\nba", "abc\nabc", "aaaa\naaab", "abcde\ncdeab", "abcde\ndeabc", "abcde\nbcdea", "abcde\nedcba",
                    "aab\nbaa", "abab\nbaba", "abab\nabba", "ab\nabab", _big + "\n" + _big_rot, _big + "\n" + _big_bad,
                    "ab" * 50000 + "\n" + "ba" * 50000, _big[:50000] + "\n" + _big[7000:50000] + _big[:7000]],
    valid=_valid_rot,
    py="import sys\na, b = sys.stdin.read().split()\nprint('true' if len(a) == len(b) and b in a + a else 'false')\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    string a, b;
    cin >> a >> b;
    if (a.size() != b.size()) { cout << "false" << endl; return 0; }
    // KMP: look for b inside a+a.
    string p = b + '#' + a + a;
    vector<int> pi(p.size(), 0);
    bool found = false;
    for (size_t i = 1; i < p.size(); i++) {
        int k = pi[i - 1];
        while (k > 0 && p[i] != p[k]) k = pi[k - 1];
        if (p[i] == p[k]) k++;
        pi[i] = k;
        if (k == (int)b.size()) { found = true; break; }
    }
    cout << (found ? "true" : "false") << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(n)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_sub(inp):
    n, a, rest = check_arr(inp, 1, 100000, -1000, 1000, 1)
    ok(-B <= int(rest[0]) <= B)


def _pm1(seed, n):
    r = rng(seed)
    return [r.choice([-1, 1]) for _ in range(n)]


add(Problem(
    slug="subarray-sum-equals-k", title="Subarray Sum Equals K", difficulty="MEDIUM", tags=["Prefix Sums", "Hashing", "Arrays"],
    story="Count the contiguous, non-empty subarrays of an integer array whose elements add up to exactly `k`. Subarrays are counted by position, so two equal-looking subarrays at different positions count separately.\n\nThe array may contain negative numbers and zeros, so a sliding window does not work here: think about prefix sums and how often each prefix sum has occurred.",
    input_fmt="The first line contains `n`. The second line contains `n` integers. The third line contains `k`.",
    output_fmt="Print the number of subarrays with sum `k`. The answer can exceed 32 bits.",
    constraints=["`1 <= n <= 100000`", "`-1000 <= a[i] <= 1000`", "`-1000000000 <= k <= 1000000000`"],
    examples=[
        ("3\n1 1 1\n2", "2", "The subarrays at positions 1..2 and 2..3 both sum to 2."),
        ("4\n1 -1 1 -1\n0", "4", "The zero-sum subarrays are positions 1..2, 2..3, 3..4 and the whole array 1..4."),
        ("5\n3 4 7 2 -3\n7", "2", "`[3, 4]` and `[7]` both sum to 7."),
    ],
    hidden=lambda: [arr_case([5], 5), arr_case([5], 4), arr_case([0] * 1000, 0), arr_case([-1, -1, 2, -2, 5], -2),
                    arr_case(_pm1(7, 2000), 2), arr_case([1] * 100000, 50000), arr_case(_pm1(8, 100000), 0),
                    arr_case([1000] * 100000, 1000 * 50000), arr_case([0, 0, 0, 1, 0, 0], 1)],
    valid=_valid_sub,
    py="import sys\nfrom collections import defaultdict\nd = sys.stdin.read().split()\nn = int(d[0])\nk = int(d[1 + n])\ncnt = defaultdict(int)\ncnt[0] = 1\ns = ans = 0\nfor x in d[1:1 + n]:\n    s += int(x)\n    ans += cnt[s - k]\n    cnt[s] += 1\nprint(ans)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    vector<long long> a(n);
    for (auto &x : a) cin >> x;
    long long k; cin >> k;
    long long ans = 0;
    if (n <= 3000) {                       // direct O(n^2) enumeration
        for (int i = 0; i < n; i++) { long long s = 0; for (int j = i; j < n; j++) { s += a[j]; if (s == k) ans++; } }
    } else {                               // prefix sums + ordered map
        map<long long, long long> seen; seen[0] = 1; long long s = 0;
        for (int i = 0; i < n; i++) { s += a[i]; auto it = seen.find(s - k); if (it != seen.end()) ans += it->second; seen[s]++; }
    }
    cout << ans << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(n)"))


# ---------------------------------------------------------------------------------------------------------------
def _rsq_case(seed, n, q, lo=-1000, hi=1000):
    r = rng(seed)
    a = [r.randint(lo, hi) for _ in range(n)]
    lines = []
    for _ in range(q):
        l = r.randint(1, n)
        rr = r.randint(l, n)
        lines.append(f"{l} {rr}")
    return f"{n} {q}\n{' '.join(map(str, a))}\n" + "\n".join(lines) + "\n"


def _valid_rsq(inp):
    ls = lines_of(inp)
    n, q = map(int, ls[0].split())
    ok(1 <= n <= 100000 and 1 <= q <= 100000 and len(ls) == 2 + q)
    ok(len(ls[1].split()) == n and all(abs(int(x)) <= B for x in ls[1].split()))
    for line in ls[2:]:
        l, r = map(int, line.split())
        ok(1 <= l <= r <= n, "bad query range")


add(Problem(
    slug="range-sum-queries", title="Range Sum Queries", difficulty="EASY", tags=["Prefix Sums", "Arrays"],
    story="You are given an array and many questions of the form *what is the sum of the elements from position `l` to position `r`?* (both ends included, positions counted from 1). Answering each question by looping over the range is too slow when there are many queries; precompute prefix sums once and answer each query in constant time.",
    input_fmt="The first line contains `n` and `q`. The second line contains the `n` array values. Each of the next `q` lines contains two integers `l` and `r`.",
    output_fmt="Print `q` lines: the answer to each query, in order.",
    constraints=["`1 <= n, q <= 100000`", "`-1000000000 <= a[i] <= 1000000000`", "`1 <= l <= r <= n`"],
    examples=[
        ("5 3\n1 2 3 4 5\n1 5\n2 3\n4 4", "15\n5\n4", "`1+2+3+4+5 = 15`, `2+3 = 5`, and the range 4..4 is just the element 4."),
        ("3 2\n-2 0 7\n1 1\n1 3", "-2\n5", "A query may cover one element (`-2`) or the whole array (`-2+0+7 = 5`)."),
    ],
    hidden=lambda: ["1 1\n5\n1 1", "1 1\n-1000000000\n1 1", "4 4\n1 1 1 1\n1 4\n2 3\n1 1\n4 4", "6 3\n1000000000 1000000000 1000000000 -1000000000 -1000000000 -1000000000\n1 6\n1 3\n4 6",
                    _rsq_case(21, 50, 60), _rsq_case(22, 5000, 5000, -B, B), _rsq_case(23, 100000, 100000, -B, B)],
    valid=_valid_rsq,
    py="import sys\nd = sys.stdin.read().split()\nn, q = int(d[0]), int(d[1])\np = [0]\nfor x in d[2:2 + n]:\n    p.append(p[-1] + int(x))\nout = []\nfor i in range(q):\n    l = int(d[2 + n + 2 * i]); r = int(d[3 + n + 2 * i])\n    out.append(p[r] - p[l - 1])\nprint('\\n'.join(map(str, out)))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, q; scanf("%d %d", &n, &q);
    vector<long long> a(n + 1);
    for (int i = 1; i <= n; i++) scanf("%lld", &a[i]);
    // Fenwick tree (binary indexed tree) instead of plain prefix sums.
    vector<long long> bit(n + 1, 0);
    for (int i = 1; i <= n; i++) for (int j = i; j <= n; j += j & -j) bit[j] += a[i];
    auto pre = [&](int i) { long long s = 0; for (; i > 0; i -= i & -i) s += bit[i]; return s; };
    while (q--) { int l, r; scanf("%d %d", &l, &r); printf("%lld\n", pre(r) - pre(l - 1)); }
}
''',
    time_complexity="O(n + q)", space_complexity="O(n)"))


# ---------------------------------------------------------------------------------------------------------------
MOD = 10 ** 9 + 7


def _valid_pes(inp):
    check_arr(inp, 2, 100000, -1000, 1000)


add(Problem(
    slug="product-of-array-except-self", title="Product of Array Except Self", difficulty="MEDIUM", tags=["Arrays", "Prefix Sums"],
    story="For every position `i`, compute the product of all the other elements of the array (everything except `a[i]`). Because products grow quickly, print every product **modulo 1000000007**, as a value in the range `0 .. 1000000006` (so a negative product is shifted into that range).\n\nThe array can contain zeros, so dividing the total product by `a[i]` is not allowed. Combine the product of the elements before `i` with the product of the elements after `i`.",
    input_fmt=" The first line contains `n`. The second line contains `n` integers.".strip(),
    output_fmt="Print `n` integers on one line separated by single spaces: for each position, the product of the other elements modulo `1000000007`.",
    constraints=["`2 <= n <= 100000`", "`-1000 <= a[i] <= 1000`"],
    examples=[
        ("4\n1 2 3 4", "24 12 8 6", "Position 1: 2*3*4 = 24. Position 2: 1*3*4 = 12. Position 3: 1*2*4 = 8. Position 4: 1*2*3 = 6."),
        ("3\n0 5 2", "10 0 0", "Excluding the zero gives 5*2 = 10; excluding any other element still leaves the zero in the product, giving 0."),
        ("3\n-1 2 -3", "1000000001 3 1000000005", "The products are -6, 3 and -2. Modulo 1000000007 the negative ones become 1000000001 and 1000000005."),
    ],
    hidden=lambda: [arr_case([1, 1]), arr_case([0, 0]), arr_case([0, 0, 3]), arr_case([-1000, 1000]), arr_case([2] * 50),
                    arr_case([1000, 1000, 1000, 1000, 1000]), arr_case([rng(31).randint(-1000, 1000) for _ in range(1000)]),
                    arr_case([rng(32).randint(1, 1000) for _ in range(100000)]), arr_case([0] + [7] * 99999)],
    valid=_valid_pes,
    py="import sys\nM = 10 ** 9 + 7\nd = sys.stdin.read().split()\nn = int(d[0])\na = [int(x) for x in d[1:1 + n]]\npre = [1] * (n + 1)\nfor i in range(n):\n    pre[i + 1] = pre[i] * a[i] % M\nsuf = [1] * (n + 1)\nfor i in range(n - 1, -1, -1):\n    suf[i] = suf[i + 1] * a[i] % M\nprint(' '.join(str(pre[i] * suf[i + 1] % M) for i in range(n)))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
const long long M = 1000000007LL;
int main() {
    int n; cin >> n;
    vector<long long> a(n);
    for (auto &x : a) { cin >> x; x = ((x % M) + M) % M; }
    vector<long long> res(n);
    if (n <= 2000) {                         // brute force: multiply everything but a[i]
        for (int i = 0; i < n; i++) { long long p = 1; for (int j = 0; j < n; j++) if (j != i) p = p * a[j] % M; res[i] = p; }
    } else {                                 // running product from the left, then from the right
        long long p = 1;
        for (int i = 0; i < n; i++) { res[i] = p; p = p * a[i] % M; }
        p = 1;
        for (int i = n - 1; i >= 0; i--) { res[i] = res[i] * p % M; p = p * a[i] % M; }
    }
    for (int i = 0; i < n; i++) cout << res[i] << (i + 1 < n ? ' ' : '\n');
}
''',
    time_complexity="O(n)", space_complexity="O(n)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_one_str(maxlen, pred):
    def v(inp):
        ls = lines_of(inp)
        ok(len(ls) == 1 and 1 <= len(ls[0]) <= maxlen and pred(ls[0]), "string violates constraints")
    return v


lower = lambda s: s.isascii() and s.islower() and s.isalpha()  # noqa: E731

add(Problem(
    slug="longest-substring-without-repeating", title="Longest Substring Without Repeating Characters", difficulty="MEDIUM",
    tags=["Sliding Window", "Hashing", "Strings"],
    story="Find the length of the longest **substring** (a contiguous part of the string) in which no character occurs twice.\n\nA window that grows to the right and jumps its left edge forward whenever it meets a repeated character finds the answer in a single pass.",
    input_fmt="One line containing the string `s`.", output_fmt="Print the length of the longest substring without repeated characters.",
    constraints=["`1 <= |s| <= 100000`", "`s` consists of lowercase English letters."],
    examples=[
        ("abcabcbb", "3", "The longest such substring is `abc` (length 3)."),
        ("bbbbb", "1", "Every window with two characters repeats `b`; the best is a single `b`."),
        ("pwwkew", "3", "`wke` has length 3. `pwke` is not contiguous, so it does not count."),
    ],
    hidden=lambda: ["a", "ab", "abba", "tmmzuxt", "dvdf", "abcdefghijklmnopqrstuvwxyz", "abcdefghijklmnopqrstuvwxyza", "aab", "abcb", rstr(41, 1500),
                    rstr(42, 100000), "ab" * 50000, "abcdefghijklmnopqrstuvwxyz" * 3846],
    valid=_valid_one_str(100000, lower),
    py="s = input().strip()\nlast = {}\nstart = best = 0\nfor i, c in enumerate(s):\n    if c in last and last[c] >= start:\n        start = last[c] + 1\n    last[c] = i\n    best = max(best, i - start + 1)\nprint(best)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    string s; cin >> s; int n = s.size(), best = 0;
    if (n <= 2000) {                                   // brute force: extend from every start until a repeat
        for (int i = 0; i < n; i++) { set<char> seen; int j = i; while (j < n && !seen.count(s[j])) seen.insert(s[j++]); best = max(best, j - i); }
    } else {                                           // two pointers with a count table
        int cnt[256] = {0}; int l = 0;
        for (int r = 0; r < n; r++) { cnt[(unsigned char)s[r]]++; while (cnt[(unsigned char)s[r]] > 1) cnt[(unsigned char)s[l++]]--; best = max(best, r - l + 1); }
    }
    cout << best << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(alphabet size)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_window(inp):
    t = inp.split()
    n, k = int(t[0]), int(t[1])
    ok(1 <= n <= 100000 and 1 <= k <= n and len(t) == 2 + n)
    ok(all(abs(int(x)) <= 10000 for x in t[2:]))


def _win_case(a, k):
    return f"{len(a)} {k}\n{' '.join(map(str, a))}\n"


add(Problem(
    slug="maximum-sum-subarray-of-size-k", title="Maximum Sum of a Window of Size K", difficulty="EASY", tags=["Sliding Window", "Arrays"],
    story="Given an array and a window size `k`, consider every block of exactly `k` consecutive elements. Print the largest sum that any such block has.\n\nInstead of re-adding `k` numbers for each block, slide the window: add the element that enters and subtract the one that leaves.",
    input_fmt="The first line contains `n` and `k`. The second line contains `n` integers.", output_fmt="Print the maximum window sum.",
    constraints=["`1 <= k <= n <= 100000`", "`-10000 <= a[i] <= 10000`"],
    examples=[
        ("6 3\n2 1 5 1 3 2", "9", "The windows sum to 8, 7, 9 and 6; the best is `5 + 1 + 3 = 9`."),
        ("4 4\n-1 -2 -3 -4", "-10", "`k = n`, so there is one window and its sum is -10."),
        ("5 1\n3 -2 7 0 7", "7", "With `k = 1` the answer is simply the largest element."),
    ],
    hidden=lambda: [_win_case([5], 1), _win_case([-5, -5], 2), _win_case([1, 2, 3, 4, 5], 2), _win_case([5, 4, 3, 2, 1], 3),
                    _win_case([-10000, 10000, -10000, 10000], 3), _win_case([rng(51).randint(-10000, 10000) for _ in range(5000)], 777),
                    _win_case([10000] * 100000, 100000), _win_case([rng(52).randint(-10000, 10000) for _ in range(100000)], 50000)],
    valid=_valid_window,
    py="import sys\nd = sys.stdin.read().split()\nn, k = int(d[0]), int(d[1])\na = [int(x) for x in d[2:2 + n]]\ns = sum(a[:k])\nbest = s\nfor i in range(k, n):\n    s += a[i] - a[i - k]\n    best = max(best, s)\nprint(best)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, k; cin >> n >> k;
    vector<long long> p(n + 1, 0);
    for (int i = 0; i < n; i++) { long long x; cin >> x; p[i + 1] = p[i] + x; }
    long long best = LLONG_MIN;
    for (int i = k; i <= n; i++) best = max(best, p[i] - p[i - k]);
    cout << best << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(1)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_small(inp):
    t = inp.split()
    n, s = int(t[0]), int(t[1])
    ok(1 <= n <= 100000 and 1 <= s <= B and len(t) == 2 + n and all(1 <= int(x) <= 10000 for x in t[2:]))


def _small_case(a, s):
    return f"{len(a)} {s}\n{' '.join(map(str, a))}\n"


add(Problem(
    slug="smallest-subarray-with-sum-at-least-s", title="Smallest Subarray With a Large Sum", difficulty="MEDIUM",
    tags=["Sliding Window", "Two Pointers", "Arrays"],
    story="All array elements are **positive**. Find the length of the shortest contiguous subarray whose sum is at least `S`. If no subarray reaches `S`, print `0`.\n\nBecause all numbers are positive, growing the window can only increase its sum and shrinking it can only decrease it, so two pointers solve it in linear time.",
    input_fmt="The first line contains `n` and `S`. The second line contains `n` positive integers.",
    output_fmt="Print the minimum length, or `0` if there is no such subarray.",
    constraints=["`1 <= n <= 100000`", "`1 <= a[i] <= 10000`", "`1 <= S <= 1000000000`"],
    examples=[
        ("6 7\n2 3 1 2 4 3", "2", "The subarray `[4, 3]` has sum 7 and length 2; no single element reaches 7."),
        ("3 100\n1 2 3", "0", "The whole array only sums to 6, so 100 is unreachable."),
        ("5 5\n1 1 1 1 5", "1", "The last element alone already reaches 5."),
    ],
    hidden=lambda: [_small_case([5], 5), _small_case([5], 6), _small_case([1, 1, 1], 3), _small_case([1, 1, 1], 2),
                    _small_case([10000] * 10, 55000), _small_case([rng(61).randint(1, 10000) for _ in range(3000)], 40000),
                    _small_case([1] * 100000, 100000), _small_case([1] * 100000, 100001), _small_case([rng(62).randint(1, 10000) for _ in range(100000)], 999999999)],
    valid=_valid_small,
    py="import sys\nd = sys.stdin.read().split()\nn, S = int(d[0]), int(d[1])\na = [int(x) for x in d[2:2 + n]]\nbest = n + 1\nl = s = 0\nfor r in range(n):\n    s += a[r]\n    while s >= S:\n        best = min(best, r - l + 1)\n        s -= a[l]\n        l += 1\nprint(best if best <= n else 0)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; long long S; cin >> n >> S;
    vector<long long> p(n + 1, 0);
    for (int i = 0; i < n; i++) { long long x; cin >> x; p[i + 1] = p[i] + x; }
    int best = 0;
    // For every start, binary search the first end whose prefix reaches S (prefix sums are increasing).
    for (int i = 0; i < n; i++) {
        int j = lower_bound(p.begin() + i + 1, p.end(), p[i] + S) - p.begin();
        if (j <= n) { int len = j - i; if (best == 0 || len < best) best = len; }
    }
    cout << best << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(1)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_3sum(inp):
    check_arr(inp, 3, 2000, -100000, 100000)


_r3 = rng(71)
add(Problem(
    slug="three-sum-distinct-triplets", title="Triplets That Sum to Zero", difficulty="MEDIUM", tags=["Two Pointers", "Sorting", "Arrays"],
    story="Count the **distinct** triplets of values `(x, y, z)` taken from three different positions of the array with `x + y + z = 0`. Two triplets are the same if they contain the same multiset of values, regardless of which positions were used or in what order the values are listed. For example `[-1, 0, 1]` found at several different positions is counted once.\n\nSort the array, fix the smallest element, and sweep the other two with two pointers, skipping repeated values.",
    input_fmt="The first line contains `n`. The second line contains `n` integers.", output_fmt="Print the number of distinct zero-sum triplets.",
    constraints=["`3 <= n <= 2000`", "`-100000 <= a[i] <= 100000`"],
    examples=[
        ("6\n-1 0 1 2 -1 -4", "2", "The distinct triplets are `[-1, -1, 2]` and `[-1, 0, 1]`; the two different `-1`s do not create extra triplets."),
        ("3\n0 0 0", "1", "The only triplet is `[0, 0, 0]`."),
        ("4\n1 2 3 4", "0", "All numbers are positive, so no triplet sums to zero."),
    ],
    hidden=lambda: [arr_case([0, 0, 0, 0]), arr_case([-2, 0, 1, 1, 2]), arr_case([-1, -1, -1, 2, 2, 2]), arr_case([-5, 2, 3]), arr_case([-5, 2, 4]),
                    arr_case([_r3.randint(-5, 5) for _ in range(120)]), arr_case([0] * 2000), arr_case([rng(72).randint(-50, 50) for _ in range(2000)]),
                    arr_case([rng(73).randint(-100000, 100000) for _ in range(2000)])],
    valid=_valid_3sum, time_limit=4.0,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\na = sorted(int(x) for x in d[1:1 + n])\ncount = 0\nfor i in range(n - 2):\n    if i and a[i] == a[i - 1]:\n        continue\n    l, r = i + 1, n - 1\n    while l < r:\n        s = a[i] + a[l] + a[r]\n        if s < 0:\n            l += 1\n        elif s > 0:\n            r -= 1\n        else:\n            count += 1\n            l += 1\n            while l < r and a[l] == a[l - 1]:\n                l += 1\nprint(count)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    vector<long long> a(n);
    for (auto &x : a) cin >> x;
    sort(a.begin(), a.end());
    if (n <= 150) {                         // brute force over all index triples, collecting distinct value triples
        set<array<long long, 3>> s;
        for (int i = 0; i < n; i++) for (int j = i + 1; j < n; j++) for (int k = j + 1; k < n; k++)
            if (a[i] + a[j] + a[k] == 0) s.insert({a[i], a[j], a[k]});
        cout << s.size() << endl;
    } else {                                // hash the pair sums of distinct values with their multiplicities
        map<long long, int> cnt; for (auto x : a) cnt[x]++;
        vector<long long> v; for (auto &p : cnt) v.push_back(p.first);
        long long total = 0;
        for (size_t i = 0; i < v.size(); i++) for (size_t j = i; j < v.size(); j++) {
            long long x = v[i], y = v[j], z = -(x + y);
            if (z < y) continue;                               // enforce x <= y <= z
            auto it = cnt.find(z); if (it == cnt.end()) continue;
            int need_x = 1 + (x == y) + (x == z), need_y = 0;  // multiplicity needed for each distinct value
            if (x == y && y == z) { if (cnt[x] >= 3) total++; }
            else if (x == y) { if (cnt[x] >= 2) total++; }
            else if (y == z) { if (cnt[y] >= 2) total++; }
            else total++;
            (void)need_x; (void)need_y;
        }
        cout << total << endl;
    }
}
''',
    time_complexity="O(n^2)", space_complexity="O(1) beyond the sorted copy"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_water(inp):
    check_arr(inp, 2, 100000, 0, 10000)


add(Problem(
    slug="container-with-most-water", title="Container With Most Water", difficulty="MEDIUM", tags=["Two Pointers", "Greedy", "Arrays"],
    story="Vertical walls stand at positions `1, 2, ..., n`; wall `i` has height `h[i]`. Choose two different walls. Together with the ground they form a container whose width is the distance between the walls and whose water level is limited by the **shorter** wall:\n\n`area = min(h[i], h[j]) * (j - i)`\n\nFind the largest area. (Ignore the thickness of the walls.)\n\nStart with the widest pair and move the pointer at the shorter wall inward: moving the taller wall can never help.",
    input_fmt="The first line contains `n`. The second line contains `n` wall heights.", output_fmt="Print the maximum area.",
    constraints=["`2 <= n <= 100000`", "`0 <= h[i] <= 10000`"],
    examples=[
        ("9\n1 8 6 2 5 4 8 3 7", "49", "Walls 2 (height 8) and 9 (height 7): width 7, level 7, area 49."),
        ("2\n1 1", "1", "Only one pair: `min(1,1) * 1 = 1`."),
        ("4\n4 3 2 1", "4", "Walls 1 and 3 (heights 4 and 2): `2 * 2 = 4`. Walls 1 and 2 give 3, walls 1 and 4 give 3."),
    ],
    hidden=lambda: [arr_case([0, 0]), arr_case([5, 5, 5, 5]), arr_case([1, 2, 3, 4, 5]), arr_case([10000, 1, 1, 1, 10000]),
                    arr_case([rng(81).randint(0, 10000) for _ in range(2000)]), arr_case([rng(82).randint(0, 10000) for _ in range(100000)]),
                    arr_case(list(range(10000, 0, -1)) * 5 if False else [10000] * 100000)],
    valid=_valid_water,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nh = [int(x) for x in d[1:1 + n]]\nl, r = 0, n - 1\nbest = 0\nwhile l < r:\n    best = max(best, min(h[l], h[r]) * (r - l))\n    if h[l] < h[r]:\n        l += 1\n    else:\n        r -= 1\nprint(best)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    vector<long long> h(n);
    for (auto &x : h) cin >> x;
    long long best = 0;
    if (n <= 3000) {                        // check every pair
        for (int i = 0; i < n; i++) for (int j = i + 1; j < n; j++) best = max(best, min(h[i], h[j]) * (j - i));
    } else {                                // for each left wall, the farthest right wall that is at least as tall
        vector<int> idx(n); iota(idx.begin(), idx.end(), 0);
        // candidate left walls: strictly increasing prefix maxima; candidate right walls: strictly increasing suffix maxima
        vector<int> L, R; long long m = -1;
        for (int i = 0; i < n; i++) if (h[i] > m) { m = h[i]; L.push_back(i); }
        m = -1;
        for (int i = n - 1; i >= 0; i--) if (h[i] > m) { m = h[i]; R.push_back(i); }
        for (int i : L) for (int j : R) if (j > i) best = max(best, min(h[i], h[j]) * (j - i));
    }
    cout << best << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(1)"))


# ---------------------------------------------------------------------------------------------------------------
add(Problem(
    slug="first-unique-character", title="First Unique Character", difficulty="EASY", tags=["Hashing", "Strings"],
    story="Find the first character of the string that appears **exactly once** in the whole string and print its position (counting from 0). If every character repeats, print `-1`.",
    input_fmt="One line containing the string `s`.", output_fmt="Print the 0-based index of the first non-repeating character, or `-1`.",
    constraints=["`1 <= |s| <= 100000`", "`s` consists of lowercase English letters."],
    examples=[
        ("leetcode", "0", "`l` occurs once and is the first character."),
        ("loveleetcode", "2", "`l` and `o` repeat; `v` at index 2 occurs once."),
        ("aabb", "-1", "Both letters occur twice."),
    ],
    hidden=lambda: ["a", "aa", "ab", "aab", "abab", "abcabcd", "zzzzzzzzzy", rstr(91, 100000), "ab" * 49999 + "c", "abcdefghijklmnopqrstuvwxyz" * 3000 + "ab"],
    valid=_valid_one_str(100000, lower),
    py="from collections import Counter\ns = input().strip()\nc = Counter(s)\nprint(next((i for i, ch in enumerate(s) if c[ch] == 1), -1))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    string s; cin >> s; int n = s.size();
    int first[26], cnt[26];
    for (int i = 0; i < 26; i++) { first[i] = -1; cnt[i] = 0; }
    for (int i = 0; i < n; i++) { int c = s[i] - 'a'; if (first[c] < 0) first[c] = i; cnt[c]++; }
    int best = -1;
    for (int c = 0; c < 26; c++) if (cnt[c] == 1 && (best < 0 || first[c] < best)) best = first[c];
    cout << best << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(alphabet size)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_cons(inp):
    check_arr(inp, 1, 100000, -B, B)


add(Problem(
    slug="longest-consecutive-sequence", title="Longest Consecutive Sequence", difficulty="MEDIUM", tags=["Hashing", "Arrays"],
    story="Given an **unsorted** array, find the length of the longest run of consecutive integers `x, x+1, x+2, ...` that all occur somewhere in the array (anywhere, in any order). Duplicates do not extend a run.\n\nSorting would take `O(n log n)`; put all values in a hash set and only start counting at values `x` for which `x - 1` is missing.",
    input_fmt=IN_ARR if False else "The first line contains `n`. The second line contains `n` integers.",
    output_fmt="Print the length of the longest run of consecutive integers present in the array.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("6\n100 4 200 1 3 2", "4", "The values 1, 2, 3, 4 are all present: a run of length 4."),
        ("5\n0 3 7 2 5", "2", "The runs are `{0}`, `{2, 3}`, `{5}` and `{7}`; the longest has length 2."),
        ("7\n1 2 0 1 2 -1 -1", "4", "The distinct values are -1, 0, 1, 2: a run of length 4. Duplicates are ignored."),
    ],
    hidden=lambda: [arr_case([7]), arr_case([5, 5, 5]), arr_case([-B, B]), arr_case([-B, -B + 1, -B + 2]), arr_case([10, 9, 8, 7, 100, 101]),
                    arr_case([rng(95).randint(-1000, 1000) for _ in range(3000)]), arr_case(list(range(100000, 0, -1))),
                    arr_case([rng(96).randint(-B, B) for _ in range(100000)]), arr_case([2 * i for i in range(50000)] + [2 * i + 1 for i in range(0, 50000, 7)])],
    valid=_valid_cons,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\ns = set(int(x) for x in d[1:1 + n])\nbest = 0\nfor x in s:\n    if x - 1 not in s:\n        y = x\n        while y + 1 in s:\n            y += 1\n        best = max(best, y - x + 1)\nprint(best)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    vector<long long> a(n);
    for (auto &x : a) cin >> x;
    sort(a.begin(), a.end());
    a.erase(unique(a.begin(), a.end()), a.end());
    int best = 1, cur = 1;
    for (size_t i = 1; i < a.size(); i++) { if (a[i] == a[i - 1] + 1) cur++; else cur = 1; best = max(best, cur); }
    cout << best << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(n)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_words(maxn, maxtotal):
    def v(inp):
        ls = inp.split()
        n = int(ls[0])
        ok(1 <= n <= maxn and len(ls) == 1 + n)
        ok(sum(len(w) for w in ls[1:]) <= maxtotal and all(lower(w) for w in ls[1:]))
    return v


add(Problem(
    slug="group-anagrams-count", title="Number of Anagram Groups", difficulty="MEDIUM", tags=["Hashing", "Strings", "Sorting"],
    story="Two words are *anagrams* if one can be rearranged into the other (they contain exactly the same letters with the same counts). Split a list of words into groups so that two words are in the same group exactly when they are anagrams. Print how many groups there are.\n\nIdentical words are anagrams of each other and fall in the same group.",
    input_fmt="The first line contains `n`. The second line contains `n` words separated by spaces.", output_fmt="Print the number of groups.",
    constraints=["`1 <= n <= 100000`", "Each word is a non-empty string of lowercase letters.", "The total length of all words is at most `200000`."],
    examples=[
        ("6\neat tea tan ate nat bat", "3", "Groups: `{eat, tea, ate}`, `{tan, nat}`, `{bat}`."),
        ("3\nabc abc cab", "1", "All three words use the letters a, b, c once each."),
        ("2\na b", "2", "Different letters: two groups."),
    ],
    hidden=lambda: ["1\nz", "2\nab ba", "2\nab abc", "4\naab aba baa abb", "5\nlisten silent enlist google gogole",
                    "5000\n" + " ".join(rstr(100 + i, 5, "abc") for i in range(5000)),
                    "100000\n" + " ".join(rstr(200 + i, 2, "abcdefghijklmnopqrstuvwxyz") for i in range(100000)),
                    "2\n" + "a" * 100000 + " " + "a" * 99999 + "b"],
    valid=_valid_words(100000, 200000),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nprint(len({''.join(sorted(w)) for w in d[1:1 + n]}))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    set<array<int, 26>> groups;                // letter-count signature instead of sorted letters
    for (int i = 0; i < n; i++) { string w; cin >> w; array<int, 26> c{}; for (char ch : w) c[ch - 'a']++; groups.insert(c); }
    cout << groups.size() << endl;
}
''',
    time_complexity="O(total length)", space_complexity="O(total length)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_rot_search(inp):
    t = inp.split()
    n = int(t[0])
    ok(1 <= n <= 100000 and len(t) == 2 + n)
    a = [int(x) for x in t[2:]]
    ok(len(set(a)) == n and all(abs(x) <= B for x in a), "values must be distinct")
    k = sum(1 for i in range(n - 1) if a[i] > a[i + 1])
    ok(k <= 1 and (k == 0 or a[-1] < a[0]), "array is not a rotation of a sorted array")


def _rot_case(a, target):
    return f"{len(a)} {target}\n{' '.join(map(str, a))}\n"


_sorted_big = sorted(rng(111).sample(range(-B, B), 100000))
add(Problem(
    slug="search-in-rotated-sorted-array", title="Search in a Rotated Sorted Array", difficulty="MEDIUM", tags=["Binary Search", "Arrays"],
    story="A sorted array of **distinct** integers was rotated at an unknown position, so for example `0 1 2 4 5 6 7` can become `4 5 6 7 0 1 2`. Given the rotated array and a `target`, print the index (counting from 0) where the target is stored, or `-1` if it is absent.\n\nYour solution must run in `O(log n)` time: in every halving step at least one half of the current range is sorted, and that tells you which half can contain the target.",
    input_fmt="The first line contains `n` and `target`. The second line contains the `n` array values.", output_fmt="Print the index of `target`, or `-1`.",
    constraints=["`1 <= n <= 100000`", "All values are distinct and lie in `[-10^9, 10^9]`.", "The array is a sorted array rotated by some number of positions (possibly zero)."],
    examples=[
        ("7 0\n4 5 6 7 0 1 2", "4", "The value 0 is stored at index 4."),
        ("7 3\n4 5 6 7 0 1 2", "-1", "3 does not occur."),
        ("1 1\n1", "0", "A single element array."),
    ],
    hidden=lambda: [_rot_case([1, 3], 3), _rot_case([3, 1], 1), _rot_case([3, 1], 3), _rot_case([1, 2, 3, 4, 5], 5), _rot_case([5, 1, 2, 3, 4], 5), _rot_case([2, 3, 4, 5, 1], 1),
                    _rot_case([6, 7, 1, 2, 3, 4, 5], 8), _rot_case(_sorted_big[31337:] + _sorted_big[:31337], _sorted_big[5]),
                    _rot_case(_sorted_big[99999:] + _sorted_big[:99999], _sorted_big[0] - 1), _rot_case(_sorted_big, _sorted_big[77777])],
    valid=_valid_rot_search,
    py="import sys\nd = sys.stdin.read().split()\nn, t = int(d[0]), int(d[1])\na = [int(x) for x in d[2:2 + n]]\nlo, hi = 0, n - 1\nans = -1\nwhile lo <= hi:\n    mid = (lo + hi) // 2\n    if a[mid] == t:\n        ans = mid\n        break\n    if a[lo] <= a[mid]:\n        if a[lo] <= t < a[mid]:\n            hi = mid - 1\n        else:\n            lo = mid + 1\n    else:\n        if a[mid] < t <= a[hi]:\n            lo = mid + 1\n        else:\n            hi = mid - 1\nprint(ans)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; long long t; cin >> n >> t;
    vector<long long> a(n);
    for (auto &x : a) cin >> x;
    // Find the rotation point (index of the minimum) by binary search, then search the sorted view.
    int lo = 0, hi = n - 1;
    while (lo < hi) { int mid = (lo + hi) / 2; if (a[mid] > a[hi]) lo = mid + 1; else hi = mid; }
    int pivot = lo, ans = -1;
    int l = 0, r = n - 1;
    while (l <= r) {
        int mid = (l + r) / 2, real = (mid + pivot) % n;
        if (a[real] == t) { ans = real; break; }
        if (a[real] < t) l = mid + 1; else r = mid - 1;
    }
    cout << ans << endl;
}
''',
    time_complexity="O(log n)", space_complexity="O(1)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_fl(inp):
    t = inp.split()
    n, x = int(t[0]), int(t[1])
    ok(1 <= n <= 100000 and len(t) == 2 + n and abs(x) <= B)
    a = [int(v) for v in t[2:]]
    ok(all(abs(v) <= B for v in a) and a == sorted(a), "array must be sorted ascending")


add(Problem(
    slug="first-and-last-position", title="First and Last Position of a Value", difficulty="MEDIUM", tags=["Binary Search", "Arrays"],
    story="A sorted array (non-decreasing, so duplicates are allowed) and a target value `x` are given. Print the index of the **first** and the index of the **last** occurrence of `x` (counting from 0). If `x` does not occur, print `-1 -1`.\n\nA plain binary search finds *some* occurrence. Use two binary searches (a lower bound and an upper bound) to find the boundaries in `O(log n)` time.",
    input_fmt="The first line contains `n` and `x`. The second line contains the `n` sorted values.",
    output_fmt="Print two integers separated by a space: the first and last index of `x`, or `-1 -1`.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i], x <= 1000000000`", "The array is sorted in non-decreasing order."],
    examples=[
        ("6 8\n5 7 7 8 8 10", "3 4", "The value 8 is stored at indices 3 and 4."),
        ("6 6\n5 7 7 8 8 10", "-1 -1", "6 does not occur (it would sit between 5 and 7)."),
        ("5 2\n2 2 2 2 2", "0 4", "Every element equals the target."),
    ],
    hidden=lambda: [f"1 5\n5\n", f"1 4\n5\n", f"2 1\n1 2\n", f"2 2\n1 2\n", f"4 -3\n-3 -3 0 9\n", f"5 100\n1 2 3 4 5\n", f"5 -100\n1 2 3 4 5\n",
                    f"100000 7\n{' '.join(['7'] * 100000)}\n", f"100000 {sorted(rng(121).randint(-5, 5) for _ in range(100000))[50000]}\n{' '.join(map(str, sorted(rng(121).randint(-5, 5) for _ in range(100000))))}\n",
                    f"100000 {_sorted_big[99999]}\n{' '.join(map(str, _sorted_big))}\n"],
    valid=_valid_fl,
    py="import sys\nfrom bisect import bisect_left, bisect_right\nd = sys.stdin.read().split()\nn, x = int(d[0]), int(d[1])\na = [int(v) for v in d[2:2 + n]]\nl = bisect_left(a, x)\nif l == n or a[l] != x:\n    print('-1 -1')\nelse:\n    print(l, bisect_right(a, x) - 1)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; long long x; cin >> n >> x;
    vector<long long> a(n);
    for (auto &v : a) cin >> v;
    // Hand-written binary searches (no library lower_bound).
    int lo = 0, hi = n;                     // first index with a[i] >= x
    while (lo < hi) { int m = (lo + hi) / 2; if (a[m] >= x) hi = m; else lo = m + 1; }
    int first = lo;
    if (first == n || a[first] != x) { cout << "-1 -1" << endl; return 0; }
    lo = first; hi = n;                     // first index with a[i] > x
    while (lo < hi) { int m = (lo + hi) / 2; if (a[m] > x) hi = m; else lo = m + 1; }
    cout << first << " " << lo - 1 << endl;
}
''',
    time_complexity="O(log n)", space_complexity="O(1)"))


# ---------------------------------------------------------------------------------------------------------------
def _valid_ship(inp):
    t = inp.split()
    n, d = int(t[0]), int(t[1])
    ok(1 <= d <= n <= 50000 and len(t) == 2 + n and all(1 <= int(x) <= 500 for x in t[2:]))


def _ship_case(w, d):
    return f"{len(w)} {d}\n{' '.join(map(str, w))}\n"


add(Problem(
    slug="minimum-shipping-capacity", title="Minimum Ship Capacity", difficulty="MEDIUM", tags=["Binary Search", "Greedy", "Arrays"],
    story="Packages with the given weights must be shipped **in the given order**. Every day the ship loads packages from the front of the remaining line, as many as fit without the total exceeding the ship's capacity `C`, and sails; you may not reorder packages or split one across days.\n\nFind the smallest capacity `C` that lets all packages be shipped within `D` days.\n\nIf capacity `C` works then any larger capacity works too, so binary search on `C` and check a candidate by simulating the days greedily.",
    input_fmt="The first line contains `n` and `D`. The second line contains the `n` package weights.", output_fmt="Print the minimum capacity.",
    constraints=["`1 <= D <= n <= 50000`", "`1 <= weight <= 500`"],
    examples=[
        ("10 5\n1 2 3 4 5 6 7 8 9 10", "15", "With capacity 15 the days carry `1 2 3 4 5` (15), `6 7` (13), `8` (8), `9` (9), `10` (10). Capacity 14 would need six days."),
        ("6 3\n3 2 2 4 1 4", "6", "Capacity 6: `3 2` (5), `2 4` (6), `1 4` (5) - three days."),
        ("3 3\n1 2 3", "3", "One package per day, so the capacity must at least fit the heaviest package."),
    ],
    hidden=lambda: [_ship_case([5], 1), _ship_case([1, 1, 1, 1], 1), _ship_case([1, 1, 1, 1], 4), _ship_case([500] * 10, 3), _ship_case([1, 2, 3, 1, 1], 4),
                    _ship_case([rng(131).randint(1, 500) for _ in range(1000)], 7), _ship_case([rng(132).randint(1, 500) for _ in range(50000)], 25000),
                    _ship_case([500] * 50000, 1), _ship_case([rng(133).randint(1, 500) for _ in range(50000)], 3)],
    valid=_valid_ship,
    py="import sys\nd = sys.stdin.read().split()\nn, D = int(d[0]), int(d[1])\nw = [int(x) for x in d[2:2 + n]]\n\ndef days(c):\n    cnt, cur = 1, 0\n    for x in w:\n        if cur + x > c:\n            cnt += 1\n            cur = 0\n        cur += x\n    return cnt\n\nlo, hi = max(w), sum(w)\nwhile lo < hi:\n    mid = (lo + hi) // 2\n    if days(mid) <= D:\n        hi = mid\n    else:\n        lo = mid + 1\nprint(lo)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, D; cin >> n >> D;
    vector<int> w(n);
    for (auto &x : w) cin >> x;
    long long sum = accumulate(w.begin(), w.end(), 0LL);
    int mx = *max_element(w.begin(), w.end());
    auto need = [&](long long c) { int d = 1; long long cur = 0; for (int x : w) { if (cur + x > c) { d++; cur = 0; } cur += x; } return d; };
    if (sum <= 200000) {                    // linear scan over capacities
        for (long long c = mx; c <= sum; c++) if (need(c) <= D) { cout << c << endl; return 0; }
    }
    long long lo = mx, hi = sum;            // otherwise binary search
    while (lo < hi) { long long mid = (lo + hi) / 2; if (need(mid) <= D) hi = mid; else lo = mid + 1; }
    cout << lo << endl;
}
''',
    time_complexity="O(n log(sum of weights))", space_complexity="O(1)"))
