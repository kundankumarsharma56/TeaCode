"""New problems, batch 2: stacks, queues, linked lists (array encoded), backtracking, trees, BST, heaps."""
from lib import Problem
from common import rng, arr_case, check_arr, lines_of

PROBLEMS = []
add = PROBLEMS.append
B = 10 ** 9


def ok(cond, msg="constraint violated"):
    if not cond:
        raise AssertionError(msg)


# ------------------------------------------------------------------ brackets
def _valid_br(inp):
    ls = lines_of(inp)
    ok(len(ls) == 1 and 1 <= len(ls[0]) <= 100000 and set(ls[0]) <= set("()[]{}"))


add(Problem(
    slug="valid-brackets", title="Balanced Brackets of Three Kinds", difficulty="EASY", tags=["Stacks", "Strings"],
    story="A string made only of the characters `(` `)` `[` `]` `{` `}` is *balanced* if every opening bracket is closed by a bracket of the **same kind**, and brackets are closed in the correct order (the most recently opened bracket must be closed first).\n\nPrint `true` if the string is balanced and `false` otherwise.",
    input_fmt="One line containing the bracket string.", output_fmt="Print `true` or `false`.",
    constraints=["`1 <= |s| <= 100000`", "`s` contains only `()[]{}`."],
    examples=[("()[]{}", "true", "Each bracket is closed immediately by its own kind."),
              ("([)]", "false", "The `[` is still open when `)` arrives, so the order is wrong."),
              ("{[()]}", "true", "The brackets are properly nested.")],
    hidden=lambda: ["(", ")", ")(", "()", "(]", "[(])", "{[]}", "((()))", "(()", "())", "()" * 50000, "(" * 50000 + ")" * 50000,
                    "(" * 50000 + ")" * 49999 + "]", "[" * 50000 + "]" * 50000, "{" + "(" * 49998 + ")" * 49998 + "]"],
    valid=_valid_br,
    py="s = input().strip()\nst = []\npair = {')': '(', ']': '[', '}': '{'}\nres = True\nfor c in s:\n    if c in '([{':\n        st.append(c)\n    elif not st or st.pop() != pair[c]:\n        res = False\n        break\nprint('true' if res and not st else 'false')\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    string s; cin >> s;
    // Reduce the string by repeatedly deleting adjacent matched pairs, using the output string as the stack.
    string r;
    for (char c : s) {
        if (!r.empty() && ((r.back() == '(' && c == ')') || (r.back() == '[' && c == ']') || (r.back() == '{' && c == '}'))) r.pop_back();
        else r.push_back(c);
    }
    cout << (r.empty() ? "true" : "false") << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(n)"))


# ------------------------------------------------------------------ next greater
def _valid_ng(inp):
    check_arr(inp, 1, 100000, -B, B)


add(Problem(
    slug="next-greater-element", title="Next Greater Element", difficulty="MEDIUM", tags=["Stacks", "Arrays"],
    story="For every element of the array, find the first element to its **right** that is strictly greater. Print that value, or `-1` if there is none.\n\nA stack that keeps the elements still waiting for a greater value (in decreasing order) solves this in one pass.",
    input_fmt="The first line contains `n`. The second line contains `n` integers.", output_fmt="Print `n` integers separated by spaces.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[("4\n4 5 2 25", "5 25 25 -1", "After 4 comes 5; after 5 the first larger is 25; after 2 comes 25; nothing is right of 25."),
              ("4\n13 7 6 12", "-1 12 12 -1", "13 has no larger element to its right; both 7 and 6 meet 12."),
              ("3\n3 3 3", "-1 -1 -1", "Equal values are not strictly greater.")],
    hidden=lambda: [arr_case([5]), arr_case([1, 2, 3, 4, 5]), arr_case([5, 4, 3, 2, 1]), arr_case([-B, B, -B, B]), arr_case([rng(1).randint(-50, 50) for _ in range(300)]),
                    arr_case(list(range(100000))), arr_case(list(range(100000, 0, -1))), arr_case([rng(2).randint(-B, B) for _ in range(100000)])],
    valid=_valid_ng,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\na = [int(x) for x in d[1:1 + n]]\nres = [-1] * n\nst = []\nfor i, x in enumerate(a):\n    while st and a[st[-1]] < x:\n        res[st.pop()] = x\n    st.append(i)\nprint(' '.join(map(str, res)))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; scanf("%d", &n);
    vector<long long> a(n), res(n, -1);
    for (auto &x : a) scanf("%lld", &x);
    vector<long long> st;                       // scan from the right keeping a decreasing stack of candidates
    for (int i = n - 1; i >= 0; i--) {
        while (!st.empty() && st.back() <= a[i]) st.pop_back();
        if (!st.empty()) res[i] = st.back();
        st.push_back(a[i]);
    }
    for (int i = 0; i < n; i++) printf("%lld%c", res[i], i + 1 < n ? ' ' : '\n');
}
''',
    time_complexity="O(n)", space_complexity="O(n)"))


# ------------------------------------------------------------------ linked list cycle
def _valid_cyc(inp):
    t = inp.split()
    n = int(t[0])
    ok(1 <= n <= 100000 and len(t) == 1 + n and all(-1 <= int(x) < n for x in t[1:]))


def _cyc(seed, n, kind):
    r = rng(seed)
    if kind == "chain":
        nxt = list(range(1, n)) + [-1]
    elif kind == "loop":
        nxt = list(range(1, n)) + [r.randint(0, n - 1)]
    elif kind == "full":
        nxt = list(range(1, n)) + [0]
    else:
        nxt = [r.randint(-1, n - 1) for _ in range(n)]
    return arr_case(nxt)


add(Problem(
    slug="linked-list-has-cycle", title="Does the Linked List Contain a Cycle?", difficulty="MEDIUM", tags=["Linked Lists", "Two Pointers"],
    story="A singly linked list with `n` nodes is stored in an array: node `i` (0-based) stores `next[i]`, the index of the node it points to, or `-1` if it is the last node. Traversal starts at **node 0**.\n\nPrint `true` if following the pointers from node 0 can go on forever (the walk enters a cycle) and `false` if it reaches `-1`. Nodes that cannot be reached from node 0 are irrelevant.\n\nThe classic technique is *fast and slow pointers*: a cycle makes them meet.",
    input_fmt="The first line contains `n`. The second line contains `n` integers `next[0..n-1]`.", output_fmt="Print `true` or `false`.",
    constraints=["`1 <= n <= 100000`", "`-1 <= next[i] <= n - 1`"],
    examples=[("3\n1 2 -1", "false", "0 -> 1 -> 2 -> end."),
              ("4\n1 2 3 1", "true", "0 -> 1 -> 2 -> 3 -> 1: nodes 1, 2, 3 form a cycle."),
              ("1\n0", "true", "A node pointing to itself is a cycle."),
              ("3\n-1 0 1", "false", "Node 0 is the end of the list immediately; the other nodes are unreachable.")],
    hidden=lambda: ["1\n-1\n", "2\n1 0\n", "2\n1 -1\n", "5\n1 2 3 4 2\n", "5\n1 2 3 4 -1\n", "4\n2 0 3 -1\n", _cyc(3, 50, "rand"), _cyc(4, 100000, "chain"),
                    _cyc(5, 100000, "loop"), _cyc(6, 100000, "full"), _cyc(7, 100000, "rand")],
    valid=_valid_cyc,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nnx = [int(x) for x in d[1:1 + n]]\nslow = fast = 0\nres = False\nwhile fast != -1 and nx[fast] != -1:\n    slow = nx[slow]\n    fast = nx[nx[fast]]\n    if slow == fast:\n        res = True\n        break\nprint('true' if res else 'false')\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    vector<int> nx(n);
    for (auto &x : nx) cin >> x;
    vector<char> seen(n, 0);                // walk from node 0 marking visited nodes
    int cur = 0; bool cyc = false;
    while (cur != -1) { if (seen[cur]) { cyc = true; break; } seen[cur] = 1; cur = nx[cur]; }
    cout << (cyc ? "true" : "false") << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(1)"))


# ------------------------------------------------------------------ remove nth from end
def _valid_rm(inp):
    t = inp.split()
    n = int(t[0])
    ok(1 <= n <= 100000 and len(t) == 2 + n and 1 <= int(t[-1]) <= n and all(abs(int(x)) <= B for x in t[1:1 + n]))


add(Problem(
    slug="remove-nth-node-from-end", title="Remove the N-th Node From the End", difficulty="MEDIUM", tags=["Linked Lists", "Two Pointers"],
    story="A linked list holds the given values from head to tail. Delete the node that is the `k`-th from the **end** (`k = 1` is the last node) and print the remaining values from head to tail. If no nodes remain print `empty`.\n\nIn a real linked list you would not know the length in advance: let one pointer run `k` steps ahead, then advance both until the front one reaches the end.",
    input_fmt="The first line contains `n`. The second line contains the `n` values. The third line contains `k`.",
    output_fmt="Print the remaining values separated by spaces, or `empty`.",
    constraints=["`1 <= k <= n <= 100000`", "`-1000000000 <= value <= 1000000000`"],
    examples=[("5\n1 2 3 4 5\n2", "1 2 3 5", "The second node from the end is 4."),
              ("1\n7\n1", "empty", "Removing the only node leaves an empty list."),
              ("2\n1 2\n2", "2", "The 2nd from the end is the head, so the head is removed.")],
    hidden=lambda: [arr_case([1, 2], 1), arr_case([4, 4, 4], 2), arr_case([-B, 0, B], 3), arr_case(list(range(10)), 10), arr_case(list(range(10)), 1),
                    arr_case([rng(9).randint(-B, B) for _ in range(100000)], 50000), arr_case([rng(10).randint(-B, B) for _ in range(100000)], 100000), arr_case([rng(11).randint(-B, B) for _ in range(100000)], 1)],
    valid=_valid_rm,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\na = d[1:1 + n]\nk = int(d[1 + n])\ndel a[n - k]\nprint(' '.join(a) if a else 'empty')\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    vector<string> v(n); for (auto &x : v) cin >> x;
    int k; cin >> k;
    // Real linked list with a dummy head and two pointers.
    vector<int> nxt(n + 1); for (int i = 0; i <= n; i++) nxt[i] = (i < n) ? i + 1 : -1;   // node i+1 stores v[i]; node 0 is the dummy
    vector<int> nx(n + 1, -1); for (int i = 0; i < n; i++) nx[i] = i + 1; nx[n] = -1;
    int fast = 0, slow = 0;
    for (int i = 0; i < k; i++) fast = nx[fast];
    while (nx[fast] != -1) { fast = nx[fast]; slow = nx[slow]; }
    nx[slow] = nx[nx[slow]];
    string out; int cur = nx[0], cnt = 0;
    while (cur != -1) { if (cnt++) out += ' '; out += v[cur - 1]; cur = nx[cur]; }
    cout << (cnt ? out : string("empty")) << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(1)"))


# ------------------------------------------------------------------ merge two lists
def _valid_mg(inp):
    ls = lines_of(inp)
    n, m = map(int, ls[0].split())
    ok(1 <= n <= 100000 and 1 <= m <= 100000 and len(ls) == 3)
    for line, c in ((ls[1], n), (ls[2], m)):
        a = [int(x) for x in line.split()]
        ok(len(a) == c and a == sorted(a) and all(abs(x) <= B for x in a), "list must be sorted")


def _mg(seed, n, m):
    r = rng(seed)
    return f"{n} {m}\n{' '.join(map(str, sorted(r.randint(-B, B) for _ in range(n))))}\n{' '.join(map(str, sorted(r.randint(-B, B) for _ in range(m))))}\n"


add(Problem(
    slug="merge-two-sorted-linked-lists", title="Merge Two Sorted Linked Lists", difficulty="EASY", tags=["Linked Lists", "Two Pointers", "Sorting"],
    story="Two linked lists are each sorted in non-decreasing order. Splice them into one sorted list and print its values from head to tail.\n\nWalk both lists with one pointer each and always take the smaller front value (take from the first list on a tie).",
    input_fmt="The first line contains `n` and `m`, the list lengths. The second line contains the first list; the third line contains the second list.",
    output_fmt="Print the `n + m` merged values separated by spaces.",
    constraints=["`1 <= n, m <= 100000`", "`-1000000000 <= value <= 1000000000`", "Both lists are sorted in non-decreasing order."],
    examples=[("3 3\n1 2 4\n1 3 4", "1 1 2 3 4 4", "Merging the fronts one by one gives `1 1 2 3 4 4`."),
              ("1 2\n5\n-1 5", "-1 5 5", "Equal values are all kept.")],
    hidden=lambda: ["1 1\n1\n2\n", "1 1\n2\n1\n", "2 2\n1 1\n1 1\n", "3 1\n-5 0 9\n100\n", "1 3\n-100\n-5 0 9\n", _mg(31, 50, 70), _mg(32, 100000, 100000), _mg(33, 100000, 1)],
    valid=_valid_mg,
    py="import sys\nd = sys.stdin.read().split()\nn, m = int(d[0]), int(d[1])\na = [int(x) for x in d[2:2 + n]]\nb = [int(x) for x in d[2 + n:2 + n + m]]\ni = j = 0\nout = []\nwhile i < n and j < m:\n    if a[i] <= b[j]:\n        out.append(a[i]); i += 1\n    else:\n        out.append(b[j]); j += 1\nout += a[i:] + b[j:]\nprint(' '.join(map(str, out)))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, m; scanf("%d %d", &n, &m);
    vector<long long> v(n + m);
    for (auto &x : v) scanf("%lld", &x);
    // Both halves are already sorted: let the library merge them in place.
    inplace_merge(v.begin(), v.begin() + n, v.end());
    for (int i = 0; i < n + m; i++) printf("%lld%c", v[i], i + 1 < n + m ? ' ' : '\n');
}
''',
    time_complexity="O(n + m)", space_complexity="O(1) extra for a real linked list"))


# ------------------------------------------------------------------ sliding window maximum
def _valid_swm(inp):
    t = inp.split()
    n, k = int(t[0]), int(t[1])
    ok(1 <= k <= n <= 100000 and len(t) == 2 + n and all(abs(int(x)) <= B for x in t[2:]))


def _sw(a, k):
    return f"{len(a)} {k}\n{' '.join(map(str, a))}\n"


add(Problem(
    slug="sliding-window-maximum", title="Sliding Window Maximum", difficulty="HARD", tags=["Queues", "Sliding Window", "Heaps"],
    story="A window of size `k` slides from the left end of the array to the right end, one position at a time. For every window position print the **maximum** value inside the window.\n\nKeep a *deque* of indices whose values are in decreasing order: the front is always the maximum of the current window, indices that leave the window are dropped from the front, and smaller values are dropped from the back as new elements arrive.",
    input_fmt="The first line contains `n` and `k`. The second line contains `n` integers.", output_fmt="Print the `n - k + 1` window maxima separated by spaces.",
    constraints=["`1 <= k <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[("8 3\n1 3 -1 -3 5 3 6 7", "3 3 5 5 6 7", "Windows: `[1 3 -1]`->3, `[3 -1 -3]`->3, `[-1 -3 5]`->5, `[-3 5 3]`->5, `[5 3 6]`->6, `[3 6 7]`->7."),
              ("3 1\n4 -2 9", "4 -2 9", "With `k = 1` every element is its own window.")],
    hidden=lambda: [_sw([5], 1), _sw([1, 2, 3, 4], 4), _sw([4, 3, 2, 1], 2), _sw([1, 2, 3, 4, 5], 2), _sw([7, 7, 7, 7], 3),
                    _sw([rng(41).randint(-20, 20) for _ in range(500)], 17), _sw(list(range(100000)), 1000), _sw(list(range(100000, 0, -1)), 50000),
                    _sw([rng(42).randint(-B, B) for _ in range(100000)], 333)],
    valid=_valid_swm,
    py="import sys\nfrom collections import deque\nd = sys.stdin.read().split()\nn, k = int(d[0]), int(d[1])\na = [int(x) for x in d[2:2 + n]]\ndq = deque()\nout = []\nfor i, x in enumerate(a):\n    while dq and a[dq[-1]] <= x:\n        dq.pop()\n    dq.append(i)\n    if dq[0] <= i - k:\n        dq.popleft()\n    if i >= k - 1:\n        out.append(a[dq[0]])\nprint(' '.join(map(str, out)))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, k; scanf("%d %d", &n, &k);
    vector<long long> a(n);
    for (auto &x : a) scanf("%lld", &x);
    multiset<long long> w;                  // ordered multiset of the current window
    vector<long long> out;
    for (int i = 0; i < n; i++) {
        w.insert(a[i]);
        if (i >= k) w.erase(w.find(a[i - k]));
        if (i >= k - 1) out.push_back(*w.rbegin());
    }
    for (size_t i = 0; i < out.size(); i++) printf("%lld%c", out[i], i + 1 < out.size() ? ' ' : '\n');
}
''',
    time_complexity="O(n)", space_complexity="O(k)"))


# ------------------------------------------------------------------ generate parentheses
add(Problem(
    slug="generate-parentheses", title="Generate Balanced Parentheses", difficulty="MEDIUM", tags=["Backtracking", "Recursion", "Strings"],
    story="Print every balanced string made of exactly `n` pairs of round brackets `(` and `)`. A string is balanced if, reading left to right, the number of `)` never exceeds the number of `(` and the totals are equal at the end.\n\nPrint the strings in **lexicographic order** where `(` comes before `)`, one per line. Backtracking works well: add `(` while fewer than `n` have been used, and add `)` only while it keeps the prefix valid.",
    input_fmt="One integer `n`.", output_fmt="Print each balanced string on its own line, in lexicographic order.",
    constraints=["`1 <= n <= 8`"],
    examples=[("1", "()", "There is exactly one balanced string with one pair."),
              ("3", "((()))\n(()())\n(())()\n()(())\n()()()", "The five balanced strings for `n = 3`, in lexicographic order.")],
    hidden=lambda: [f"{i}\n" for i in (2, 4, 5, 6, 7, 8)],
    valid=lambda inp: ok(len(lines_of(inp)) == 1 and 1 <= int(inp) <= 8),
    py="n = int(input())\nout = []\n\ndef go(s, o, c):\n    if len(s) == 2 * n:\n        out.append(s)\n        return\n    if o < n:\n        go(s + '(', o + 1, c)\n    if c < o:\n        go(s + ')', o, c + 1)\n\ngo('', 0, 0)\nprint('\\n'.join(out))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n; int L = 2 * n;
    // Enumerate every bit pattern in increasing order (0 = '(' < 1 = ')') and keep the balanced ones.
    for (long long mask = 0; mask < (1LL << L); mask++) {
        int bal = 0; bool good = true; string s;
        for (int i = L - 1; i >= 0; i--) {
            int bit = (mask >> i) & 1;
            bal += bit ? -1 : 1; s += bit ? ')' : '(';
            if (bal < 0) { good = false; break; }
        }
        if (good && bal == 0) cout << s << "\n";
    }
}
''',
    time_complexity="O(4^n / sqrt(n))", space_complexity="O(n) recursion depth"))


# ------------------------------------------------------------------ count subsets with sum
def _valid_ss(inp):
    t = inp.split()
    n, k = int(t[0]), int(t[1])
    ok(1 <= n <= 20 and 1 <= k <= 1000 and len(t) == 2 + n and all(1 <= int(x) <= 50 for x in t[2:]))


def _ss(a, k):
    return f"{len(a)} {k}\n{' '.join(map(str, a))}\n"


add(Problem(
    slug="count-subsets-with-sum", title="Count Subsets With a Given Sum", difficulty="MEDIUM", tags=["Backtracking", "Recursion", "Dynamic Programming"],
    story="Count the subsets of the array (choosing any set of **positions**) whose elements add up to exactly `K`. Equal values at different positions are different elements, so they give different subsets. The empty subset is never counted because `K >= 1`.\n\nWith at most 20 elements you may try both choices (take or skip) for every element.",
    input_fmt="The first line contains `n` and `K`. The second line contains `n` positive integers.", output_fmt="Print the number of subsets with sum `K`.",
    constraints=["`1 <= n <= 20`", "`1 <= a[i] <= 50`", "`1 <= K <= 1000`"],
    examples=[("4 5\n1 2 3 4", "2", "`{2, 3}` and `{1, 4}` both sum to 5."),
              ("3 2\n1 1 1", "3", "Any two of the three equal elements: three different position pairs."),
              ("2 10\n3 4", "0", "The total is 7, so 10 is unreachable.")],
    hidden=lambda: [_ss([5], 5), _ss([5], 4), _ss([1] * 20, 10), _ss([50] * 20, 1000), _ss([50] * 20, 50), _ss([rng(51).randint(1, 50) for _ in range(20)], 300),
                    _ss([rng(52).randint(1, 5) for _ in range(20)], 30), _ss(list(range(1, 21)), 105), _ss([1, 2, 4, 8, 16, 32, 1, 2, 4, 8, 16, 32], 63)],
    valid=_valid_ss,
    py="import sys\nd = sys.stdin.read().split()\nn, K = int(d[0]), int(d[1])\na = [int(x) for x in d[2:2 + n]]\n\ndef go(i, rem):\n    if rem == 0:\n        return 1\n    if i == n or rem < 0:\n        return 0\n    return go(i + 1, rem - a[i]) + go(i + 1, rem)\n\nprint(go(0, K))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, K; cin >> n >> K;
    vector<int> a(n); for (auto &x : a) cin >> x;
    vector<long long> dp(K + 1, 0); dp[0] = 1;       // dp[s] = number of subsets so far with sum s
    for (int x : a) for (int s = K; s >= x; s--) dp[s] += dp[s - x];
    cout << dp[K] << endl;
}
''',
    time_complexity="O(n * K) with DP (2^n by plain backtracking)", space_complexity="O(K)"))


# ------------------------------------------------------------------ trees
def gen_tree(seed, n, shape):
    r = rng(seed)
    l = [0] * (n + 1)
    rt = [0] * (n + 1)
    if shape == "chain":
        for i in range(2, n + 1):
            if r.random() < 0.5:
                l[i - 1] = i
            else:
                rt[i - 1] = i
    else:
        slots = [(1, 0), (1, 1)]
        for i in range(2, n + 1):
            j = r.randrange(len(slots))
            slots[j], slots[-1] = slots[-1], slots[j]
            p, side = slots.pop()
            if side == 0:
                l[p] = i
            else:
                rt[p] = i
            slots += [(i, 0), (i, 1)]
    return l, rt


def _tree_ok(n, kids):
    seen = {1}
    stack = [1]
    cnt = 0
    while stack:
        u = stack.pop()
        cnt += 1
        for c in kids(u):
            ok(c not in seen and 1 <= c <= n, "not a tree")
            seen.add(c)
            stack.append(c)
    ok(cnt == n, "tree is not connected")


def _valid_depth(inp):
    ls = lines_of(inp)
    n = int(ls[0])
    ok(1 <= n <= 100000 and len(ls) == 1 + n)
    ch = [tuple(map(int, x.split())) for x in ls[1:]]
    ok(all(0 <= a <= n and 0 <= b <= n for a, b in ch))
    _tree_ok(n, lambda u: [c for c in ch[u - 1] if c])


def tree_txt(l, r, n):
    return f"{n}\n" + "\n".join(f"{l[i]} {r[i]}" for i in range(1, n + 1)) + "\n"


add(Problem(
    slug="maximum-depth-of-binary-tree", title="Maximum Depth of a Binary Tree", difficulty="EASY", tags=["Trees", "DFS", "BFS"],
    story="A binary tree has `n` nodes numbered `1..n`; node `1` is the root. For each node you are given the numbers of its left and right children, with `0` meaning *no child*.\n\nThe **depth** of the tree is the number of nodes on the longest path from the root down to a leaf. Print it. (A tree with a single node has depth 1.)\n\nNote that a tree can be 100000 levels deep, so a naive recursive solution may overflow the stack in some languages.",
    input_fmt="The first line contains `n`. Each of the next `n` lines contains two integers: the left and right child of node `i` (`0` if absent).", output_fmt="Print the depth.",
    constraints=["`1 <= n <= 100000`", "The input describes a valid binary tree rooted at node 1."],
    examples=[("5\n2 3\n4 5\n0 0\n0 0\n0 0", "3", "Path 1 -> 2 -> 4 has three nodes."),
              ("1\n0 0", "1", "A single node."),
              ("3\n0 2\n0 3\n0 0", "3", "The tree is a chain going right: 1 -> 2 -> 3.")],
    hidden=lambda: [tree_txt(*gen_tree(61, 2, "chain"), 2), tree_txt(*gen_tree(62, 7, "rand"), 7), tree_txt(*gen_tree(63, 100, "rand"), 100),
                    tree_txt(*gen_tree(64, 100000, "chain"), 100000), tree_txt(*gen_tree(65, 100000, "rand"), 100000), tree_txt(*gen_tree(66, 99999, "rand"), 99999)],
    valid=_valid_depth,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nL = [0] * (n + 1)\nR = [0] * (n + 1)\nfor i in range(1, n + 1):\n    L[i] = int(d[2 * i - 1])\n    R[i] = int(d[2 * i])\nlevel = [1]\ndepth = 0\nwhile level:\n    depth += 1\n    nxt = []\n    for u in level:\n        if L[u]:\n            nxt.append(L[u])\n        if R[u]:\n            nxt.append(R[u])\n    level = nxt\nprint(depth)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; scanf("%d", &n);
    vector<int> L(n + 1), R(n + 1);
    for (int i = 1; i <= n; i++) scanf("%d %d", &L[i], &R[i]);
    int best = 0;
    vector<pair<int, int>> st{{1, 1}};          // iterative depth-first traversal with explicit depths
    while (!st.empty()) {
        auto [u, d] = st.back(); st.pop_back();
        best = max(best, d);
        if (L[u]) st.push_back({L[u], d + 1});
        if (R[u]) st.push_back({R[u], d + 1});
    }
    printf("%d\n", best);
}
''',
    time_complexity="O(n)", space_complexity="O(n)"))


# ------------------------------------------------------------------ validate BST
def bst_gen(seed, n, shape, break_it=False):
    r = rng(seed)
    if shape == "chain":
        vals = sorted(r.sample(range(-B, B), n))
        l = [0] * (n + 1)
        rt = [0] * (n + 1)
        for i in range(1, n):
            rt[i] = i + 1
    else:
        vals = r.sample(range(-B, B), n)
        l = [0] * (n + 1)
        rt = [0] * (n + 1)
        for i in range(2, n + 1):
            cur = 1
            while True:
                if vals[i - 1] < vals[cur - 1]:
                    if l[cur]:
                        cur = l[cur]
                    else:
                        l[cur] = i
                        break
                else:
                    if rt[cur]:
                        cur = rt[cur]
                    else:
                        rt[cur] = i
                        break
    vals = list(vals)
    if break_it and n >= 2:
        vals[0], vals[n - 1] = vals[n - 1], vals[0]
    return "".join([f"{n}\n"] + [f"{vals[i]} {l[i + 1]} {rt[i + 1]}\n" for i in range(n)])


def _valid_bst(inp):
    ls = lines_of(inp)
    n = int(ls[0])
    ok(1 <= n <= 100000 and len(ls) == 1 + n)
    rows = [tuple(map(int, x.split())) for x in ls[1:]]
    ok(all(abs(v) <= B and 0 <= a <= n and 0 <= b <= n for v, a, b in rows))
    _tree_ok(n, lambda u: [c for c in rows[u - 1][1:] if c])


add(Problem(
    slug="validate-binary-search-tree", title="Validate a Binary Search Tree", difficulty="MEDIUM", tags=["Binary Search Trees", "Trees", "DFS"],
    story="A binary tree has `n` nodes numbered `1..n` (node `1` is the root). Each node has an integer value. The tree is a valid **binary search tree** if for every node, *all* values in its left subtree are **strictly smaller** than the node's value and *all* values in its right subtree are **strictly greater**. Checking only a node's direct children is not enough.\n\nPrint `true` if the tree is a valid BST and `false` otherwise.",
    input_fmt="The first line contains `n`. Each of the next `n` lines contains three integers: the value of node `i`, its left child and its right child (`0` means *no child*).", output_fmt="Print `true` or `false`.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= value <= 1000000000`", "The input describes a valid binary tree rooted at node 1."],
    examples=[("3\n2 2 3\n1 0 0\n3 0 0", "true", "Left value 1 < 2 < right value 3."),
              ("3\n5 2 3\n1 0 0\n4 0 0", "false", "The right child 4 is smaller than the root 5."),
              ("5\n10 2 3\n5 0 0\n15 4 5\n6 0 0\n20 0 0", "false", "Node 4 (value 6) is the left child of 15 and looks fine locally, but it sits in the right subtree of 10 and 6 < 10."),
              ("2\n2 2 0\n2 0 0", "false", "Equal values are not allowed: 2 is not strictly smaller than 2.")],
    hidden=lambda: [bst_gen(71, 1, "rand"), bst_gen(72, 7, "rand"), bst_gen(73, 7, "rand", True), bst_gen(74, 200, "rand"), bst_gen(75, 200, "rand", True),
                    bst_gen(76, 100000, "rand"), bst_gen(77, 100000, "rand", True), bst_gen(78, 100000, "chain"), bst_gen(79, 100000, "chain", True),
                    "3\n2 2 3\n3 0 0\n4 0 0\n"],
    valid=_valid_bst,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nV = [0] * (n + 1); L = [0] * (n + 1); R = [0] * (n + 1)\nfor i in range(1, n + 1):\n    V[i] = int(d[3 * i - 2]); L[i] = int(d[3 * i - 1]); R[i] = int(d[3 * i])\nINF = 10 ** 18\nst = [(1, -INF, INF)]\nres = True\nwhile st and res:\n    u, lo, hi = st.pop()\n    if not (lo < V[u] < hi):\n        res = False\n        break\n    if L[u]:\n        st.append((L[u], lo, V[u]))\n    if R[u]:\n        st.append((R[u], V[u], hi))\nprint('true' if res else 'false')\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; scanf("%d", &n);
    vector<long long> V(n + 1); vector<int> L(n + 1), R(n + 1);
    for (int i = 1; i <= n; i++) scanf("%lld %d %d", &V[i], &L[i], &R[i]);
    // In-order traversal (iterative); a BST visits values in strictly increasing order.
    vector<int> st; int cur = 1; long long prev = LLONG_MIN; bool good = true;
    while ((cur || !st.empty()) && good) {
        while (cur) { st.push_back(cur); cur = L[cur]; }
        cur = st.back(); st.pop_back();
        if (V[cur] <= prev) good = false;
        prev = V[cur];
        cur = R[cur];
    }
    puts(good ? "true" : "false");
}
''',
    time_complexity="O(n)", space_complexity="O(n)"))


# ------------------------------------------------------------------ heaps
def _valid_kth(inp):
    t = inp.split()
    n, k = int(t[0]), int(t[1])
    ok(1 <= k <= n <= 100000 and len(t) == 2 + n and all(abs(int(x)) <= B for x in t[2:]))


add(Problem(
    slug="kth-largest-element", title="K-th Largest Element", difficulty="MEDIUM", tags=["Heaps", "Sorting", "Arrays"],
    story="Find the `k`-th largest element of an unsorted array. Duplicates count separately: in `5 5 3` the 1st and 2nd largest are both 5 and the 3rd largest is 3.\n\nSorting works, but a *min-heap* that never holds more than `k` elements finds the answer in `O(n log k)`.",
    input_fmt="The first line contains `n` and `k`. The second line contains `n` integers.", output_fmt="Print the `k`-th largest element.",
    constraints=["`1 <= k <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[("6 2\n3 2 1 5 6 4", "5", "Sorted descending: 6 5 4 3 2 1. The 2nd is 5."),
              ("9 4\n3 2 3 1 2 4 5 5 6", "4", "Sorted descending: 6 5 5 4 3 3 2 2 1; the 4th is 4 (duplicates count)."),
              ("1 1\n-7", "-7", "A single element.")],
    hidden=lambda: [_sw([2, 2], 1), _sw([2, 2], 2), _sw([1, 2, 3, 4, 5], 5), _sw([1, 2, 3, 4, 5], 1), _sw([-B, B], 2), _sw([rng(81).randint(-5, 5) for _ in range(400)], 123),
                    _sw([rng(82).randint(-B, B) for _ in range(100000)], 50000), _sw([rng(83).randint(-B, B) for _ in range(100000)], 1), _sw([rng(84).randint(-B, B) for _ in range(100000)], 100000)],
    valid=_valid_kth,
    py="import sys, heapq\nd = sys.stdin.read().split()\nn, k = int(d[0]), int(d[1])\nh = []\nfor x in d[2:2 + n]:\n    x = int(x)\n    if len(h) < k:\n        heapq.heappush(h, x)\n    elif x > h[0]:\n        heapq.heapreplace(h, x)\nprint(h[0])\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, k; scanf("%d %d", &n, &k);
    vector<long long> a(n);
    for (auto &x : a) scanf("%lld", &x);
    nth_element(a.begin(), a.begin() + (k - 1), a.end(), greater<long long>());   // quickselect
    printf("%lld\n", a[k - 1]);
}
''',
    time_complexity="O(n log k)", space_complexity="O(k)"))


def _valid_med(inp):
    check_arr(inp, 1, 100000, -B, B)


add(Problem(
    slug="running-median", title="Running Median of a Stream", difficulty="HARD", tags=["Heaps", "Arrays"],
    story="Numbers arrive one at a time. After each number, print the **median** of all numbers received so far. When the count is even, print the *lower* of the two middle values (so the answer is always one of the numbers, never a fraction).\n\nEquivalently, after sorting the first `i` numbers print the element at position `(i + 1) / 2` (1-based, integer division).\n\nTwo heaps (a max-heap for the smaller half, a min-heap for the larger half) keep the median at the top in `O(log n)` per number.",
    input_fmt="The first line contains `n`. The second line contains `n` integers in order of arrival.", output_fmt="Print `n` integers separated by spaces: the median after each arrival.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[("5\n5 15 1 3 8", "5 5 5 3 5", "Sorted prefixes: `5`, `5 15`, `1 5 15`, `1 3 5 15`, `1 3 5 8 15` -> medians 5, 5 (lower of 5 and 15), 5, 3 (lower of 3 and 5), 5."),
              ("3\n-1 -2 -3", "-1 -2 -2", "Prefix `-2 -1` has lower middle `-2`; prefix `-3 -2 -1` has middle `-2`.")],
    hidden=lambda: [arr_case([4]), arr_case([2, 2, 2, 2]), arr_case([1, 2, 3, 4, 5, 6]), arr_case([6, 5, 4, 3, 2, 1]), arr_case([rng(91).randint(-10, 10) for _ in range(300)]),
                    arr_case([rng(92).randint(-B, B) for _ in range(100000)]), arr_case(list(range(100000))), arr_case(list(range(100000, 0, -1)))],
    valid=_valid_med,
    py="import sys, heapq\nd = sys.stdin.read().split()\nn = int(d[0])\nlo = []\nhi = []\nout = []\nfor x in d[1:1 + n]:\n    x = int(x)\n    heapq.heappush(lo, -x)\n    heapq.heappush(hi, -heapq.heappop(lo))\n    if len(hi) > len(lo):\n        heapq.heappush(lo, -heapq.heappop(hi))\n    out.append(-lo[0])\nprint(' '.join(map(str, out)))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; scanf("%d", &n);
    vector<long long> a(n);
    for (auto &x : a) scanf("%lld", &x);
    // Fenwick tree over compressed values, then find the ((i+1)/2)-th smallest by binary descent.
    vector<long long> s = a; sort(s.begin(), s.end()); s.erase(unique(s.begin(), s.end()), s.end());
    int m = s.size(), LOG = 1; while ((1 << LOG) <= m) LOG++;
    vector<int> bit(m + 1, 0);
    for (int i = 0; i < n; i++) {
        int p = lower_bound(s.begin(), s.end(), a[i]) - s.begin() + 1;
        for (int j = p; j <= m; j += j & -j) bit[j]++;
        int rank = (i + 2) / 2, pos = 0;
        for (int b = LOG; b >= 0; b--) { int np = pos + (1 << b); if (np <= m && bit[np] < rank) { pos = np; rank -= bit[np]; } }
        printf("%lld%c", s[pos], i + 1 < n ? ' ' : '\n');
    }
}
''',
    time_complexity="O(n log n)", space_complexity="O(n)"))
