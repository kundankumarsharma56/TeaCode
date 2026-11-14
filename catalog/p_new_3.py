"""New problems, batch 3: graphs, BFS/DFS, union find, topological sort, intervals, greedy, DP, bits, tries, number theory, matrices."""
from lib import Problem
from common import rng, arr_case, check_arr, lines_of

PROBLEMS = []
add = PROBLEMS.append
B = 10 ** 9


def ok(cond, msg="constraint violated"):
    if not cond:
        raise AssertionError(msg)


def edges_txt(head, edges):
    return head + "\n" + "".join(f"{u} {v}\n" for u, v in edges)


# ------------------------------------------------------------------ islands
def grid_txt(rows):
    return f"{len(rows)} {len(rows[0])}\n" + "\n".join(rows) + "\n"


def _valid_grid(inp):
    ls = lines_of(inp)
    r, c = map(int, ls[0].split())
    ok(1 <= r <= 500 and 1 <= c <= 500 and len(ls) == 1 + r)
    ok(all(len(x) == c and set(x) <= set("01") for x in ls[1:]))


def _rand_grid(seed, r, c, p):
    g = rng(seed)
    return grid_txt(["".join("1" if g.random() < p else "0" for _ in range(c)) for _ in range(r)])


add(Problem(
    slug="number-of-islands", title="Count the Islands", difficulty="MEDIUM", tags=["Graphs", "DFS", "BFS", "Matrices"],
    story="A map is a grid of `0` (water) and `1` (land). An **island** is a maximal group of land cells connected horizontally or vertically (diagonal neighbours are **not** connected). Count the islands.",
    input_fmt="The first line contains `R` and `C`. Each of the next `R` lines is a string of `C` characters, each `0` or `1`.", output_fmt="Print the number of islands.",
    constraints=["`1 <= R, C <= 500`"],
    examples=[("4 5\n11000\n11000\n00100\n00011", "3", "Top-left block, the single middle cell and the bottom-right pair."),
              ("1 1\n0", "0", "Only water."),
              ("3 3\n101\n010\n101", "5", "Diagonal cells are not connected, so each `1` is its own island.")],
    hidden=lambda: ["1 1\n1\n", "1 5\n10101\n", "5 1\n1\n1\n0\n1\n1\n", grid_txt(["1" * 500] * 500), grid_txt(["".join("1" if (i + j) % 2 == 0 else "0" for j in range(500)) for i in range(500)]),
                    _rand_grid(1, 30, 40, 0.4), _rand_grid(2, 500, 500, 0.5), _rand_grid(3, 500, 500, 0.62), grid_txt(["0" * 500] * 500)],
    valid=_valid_grid,
    py="import sys\nd = sys.stdin.read().split()\nr, c = int(d[0]), int(d[1])\ng = [bytearray(row.encode()) for row in d[2:2 + r]]\ncnt = 0\nfor i in range(r):\n    for j in range(c):\n        if g[i][j] == 49:\n            cnt += 1\n            g[i][j] = 48\n            st = [(i, j)]\n            while st:\n                x, y = st.pop()\n                for nx, ny in ((x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)):\n                    if 0 <= nx < r and 0 <= ny < c and g[nx][ny] == 49:\n                        g[nx][ny] = 48\n                        st.append((nx, ny))\nprint(cnt)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
vector<int> p;
int f(int x) { while (p[x] != x) { p[x] = p[p[x]]; x = p[x]; } return x; }
int main() {
    int r, c; cin >> r >> c;
    vector<string> g(r); for (auto &s : g) cin >> s;
    p.resize(r * c); iota(p.begin(), p.end(), 0);
    for (int i = 0; i < r; i++) for (int j = 0; j < c; j++) if (g[i][j] == '1') {
        if (i + 1 < r && g[i + 1][j] == '1') p[f(i * c + j)] = f((i + 1) * c + j);
        if (j + 1 < c && g[i][j + 1] == '1') p[f(i * c + j)] = f(i * c + j + 1);
    }
    int cnt = 0;
    for (int i = 0; i < r; i++) for (int j = 0; j < c; j++) if (g[i][j] == '1' && f(i * c + j) == i * c + j) cnt++;
    cout << cnt << endl;
}
''',
    time_complexity="O(R * C)", space_complexity="O(R * C)"))


# ------------------------------------------------------------------ shortest path
def _rand_edges(seed, n, m):
    r = rng(seed)
    out = []
    while len(out) < m:
        u, v = r.randint(1, n), r.randint(1, n)
        if u != v:
            out.append((u, v))
    return out


def _valid_sp(inp):
    ls = lines_of(inp)
    n, m, s, t = map(int, ls[0].split())
    ok(1 <= n <= 100000 and 1 <= m <= 200000 and 1 <= s <= n and 1 <= t <= n and len(ls) == 1 + m)
    for line in ls[1:]:
        u, v = map(int, line.split())
        ok(1 <= u <= n and 1 <= v <= n and u != v)


add(Problem(
    slug="shortest-path-fewest-edges", title="Fewest Roads Between Two Cities", difficulty="MEDIUM", tags=["Graphs", "BFS"],
    story="There are `n` cities and `m` two-way roads. Find the minimum number of roads you must travel to get from city `s` to city `t`, or print `-1` if `t` cannot be reached. All roads count the same, so a breadth-first search from `s` finds the answer.",
    input_fmt="The first line contains `n`, `m`, `s` and `t`. Each of the next `m` lines contains two cities `u` and `v` joined by a road.", output_fmt="Print the minimum number of roads, or `-1`.",
    constraints=["`1 <= n <= 100000`, `1 <= m <= 200000`", "`1 <= s, t, u, v <= n`, `u != v`", "Several roads may connect the same pair of cities."],
    examples=[("5 5 1 5\n1 2\n2 3\n3 5\n1 4\n4 5", "2", "The route 1 -> 4 -> 5 uses two roads."),
              ("4 1 1 4\n1 2", "-1", "City 4 is not connected to city 1."),
              ("3 2 2 2\n1 2\n2 3", "0", "Start and destination are the same city.")],
    hidden=lambda: [edges_txt("2 1 1 2", [(1, 2)]), edges_txt("2 1 2 1", [(1, 2)]), edges_txt("6 4 1 6", [(1, 2), (2, 3), (4, 5), (5, 6)]),
                    edges_txt("100000 99999 1 100000", [(i, i + 1) for i in range(1, 100000)]), edges_txt("100000 200000 7 99999", _rand_edges(11, 100000, 200000)),
                    edges_txt("50000 60000 1 50000", _rand_edges(12, 50000, 60000)), edges_txt("1000 1000 3 4", _rand_edges(13, 1000, 1000))],
    valid=_valid_sp,
    py="import sys\nfrom collections import deque\nd = sys.stdin.buffer.read().split()\nn, m, s, t = int(d[0]), int(d[1]), int(d[2]), int(d[3])\nadj = [[] for _ in range(n + 1)]\nfor i in range(m):\n    u = int(d[4 + 2 * i]); v = int(d[5 + 2 * i])\n    adj[u].append(v)\n    adj[v].append(u)\ndist = [-1] * (n + 1)\ndist[s] = 0\nq = deque([s])\nwhile q:\n    u = q.popleft()\n    for v in adj[u]:\n        if dist[v] < 0:\n            dist[v] = dist[u] + 1\n            q.append(v)\nprint(dist[t])\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, m, s, t; scanf("%d %d %d %d", &n, &m, &s, &t);
    vector<vector<int>> adj(n + 1);
    for (int i = 0; i < m; i++) { int u, v; scanf("%d %d", &u, &v); adj[u].push_back(v); adj[v].push_back(u); }
    // Dijkstra with unit weights (independent of the BFS formulation).
    vector<int> dist(n + 1, INT_MAX);
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
    dist[s] = 0; pq.push({0, s});
    while (!pq.empty()) {
        auto [d, u] = pq.top(); pq.pop();
        if (d > dist[u]) continue;
        for (int v : adj[u]) if (dist[v] > d + 1) { dist[v] = d + 1; pq.push({dist[v], v}); }
    }
    printf("%d\n", dist[t] == INT_MAX ? -1 : dist[t]);
}
''',
    time_complexity="O(n + m)", space_complexity="O(n + m)"))


# ------------------------------------------------------------------ course schedule
def _valid_cs(inp):
    ls = lines_of(inp)
    n, m = map(int, ls[0].split())
    ok(1 <= n <= 100000 and 1 <= m <= 200000 and len(ls) == 1 + m)
    for line in ls[1:]:
        a, b = map(int, line.split())
        ok(1 <= a <= n and 1 <= b <= n)


def _dag(seed, n, m, cycle):
    r = rng(seed)
    perm = list(range(1, n + 1))
    r.shuffle(perm)
    e = []
    for _ in range(m):
        i, j = r.sample(range(n), 2)
        if i > j:
            i, j = j, i
        e.append((perm[i], perm[j]))
    if cycle:
        e.append((perm[n - 1], perm[0]))
        e.append((perm[0], perm[n - 1]))
        m += 2
    r.shuffle(e)
    return edges_txt(f"{n} {len(e)}", e)


add(Problem(
    slug="course-schedule-possible", title="Can All Courses Be Completed?", difficulty="MEDIUM", tags=["Topological Sort", "Graphs", "DFS"],
    story="There are `n` courses numbered `1..n` and `m` prerequisite rules. A rule `a b` means course `a` must be completed **before** course `b`. You can take one course at a time, in any order that respects every rule.\n\nPrint `true` if all `n` courses can be completed and `false` if the rules contradict each other (they form a cycle, including a course that is its own prerequisite).",
    input_fmt="The first line contains `n` and `m`. Each of the next `m` lines contains `a` and `b`.", output_fmt="Print `true` or `false`.",
    constraints=["`1 <= n <= 100000`, `1 <= m <= 200000`", "`1 <= a, b <= n`"],
    examples=[("4 3\n1 2\n2 3\n3 4", "true", "Take the courses in the order 1, 2, 3, 4."),
              ("2 2\n1 2\n2 1", "false", "Each course must come before the other."),
              ("3 1\n2 2", "false", "Course 2 would have to be completed before itself.")],
    hidden=lambda: ["3 2\n1 3\n2 3\n", "3 3\n1 2\n2 3\n3 1\n", "5 4\n5 4\n4 3\n3 2\n2 1\n", "1 1\n1 1\n", _dag(21, 30, 60, False), _dag(22, 30, 60, True),
                    _dag(23, 100000, 200000, False), _dag(24, 100000, 199998, True), edges_txt("100000 99999", [(i, i + 1) for i in range(1, 100000)]),
                    edges_txt("100000 100000", [(i, i + 1) for i in range(1, 100000)] + [(100000, 1)])],
    valid=_valid_cs,
    py="import sys\nfrom collections import deque\nd = sys.stdin.buffer.read().split()\nn, m = int(d[0]), int(d[1])\nadj = [[] for _ in range(n + 1)]\nindeg = [0] * (n + 1)\nfor i in range(m):\n    a = int(d[2 + 2 * i]); b = int(d[3 + 2 * i])\n    adj[a].append(b)\n    indeg[b] += 1\nq = deque(i for i in range(1, n + 1) if indeg[i] == 0)\ndone = 0\nwhile q:\n    u = q.popleft()\n    done += 1\n    for v in adj[u]:\n        indeg[v] -= 1\n        if indeg[v] == 0:\n            q.append(v)\nprint('true' if done == n else 'false')\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, m; scanf("%d %d", &n, &m);
    vector<vector<int>> adj(n + 1);
    for (int i = 0; i < m; i++) { int a, b; scanf("%d %d", &a, &b); adj[a].push_back(b); }
    // Iterative depth-first search with three colours: finding a grey node again means a cycle.
    vector<int> color(n + 1, 0), it(n + 1, 0);
    bool cyc = false;
    for (int s = 1; s <= n && !cyc; s++) {
        if (color[s]) continue;
        vector<int> st{s}; color[s] = 1;
        while (!st.empty() && !cyc) {
            int u = st.back();
            if (it[u] < (int)adj[u].size()) {
                int v = adj[u][it[u]++];
                if (color[v] == 1) cyc = true;
                else if (color[v] == 0) { color[v] = 1; st.push_back(v); }
            } else { color[u] = 2; st.pop_back(); }
        }
    }
    puts(cyc ? "false" : "true");
}
''',
    time_complexity="O(n + m)", space_complexity="O(n + m)"))


# ------------------------------------------------------------------ components
def _valid_cc(inp):
    ls = lines_of(inp)
    n, m = map(int, ls[0].split())
    ok(1 <= n <= 100000 and 1 <= m <= 200000 and len(ls) == 1 + m)
    for line in ls[1:]:
        u, v = map(int, line.split())
        ok(1 <= u <= n and 1 <= v <= n)


def _re2(seed, n, m):
    r = rng(seed)
    return [(r.randint(1, n), r.randint(1, n)) for _ in range(m)]


add(Problem(
    slug="count-connected-components", title="Count Connected Components", difficulty="EASY", tags=["Union Find", "Graphs", "DFS"],
    story="An undirected graph has `n` vertices and `m` edges. Two vertices are in the same *component* if there is a path between them. Count the components (an isolated vertex is a component by itself).\n\nA disjoint-set (union-find) structure merges the endpoints of every edge; the answer is the number of sets left.",
    input_fmt="The first line contains `n` and `m`. Each of the next `m` lines contains two vertices `u` and `v`.", output_fmt="Print the number of components.",
    constraints=["`1 <= n <= 100000`, `1 <= m <= 200000`", "`1 <= u, v <= n`; self-loops and repeated edges may occur."],
    examples=[("5 3\n1 2\n2 3\n4 5", "2", "Components `{1, 2, 3}` and `{4, 5}`."),
              ("4 1\n1 2", "3", "`{1, 2}`, `{3}` and `{4}`."),
              ("1 1\n1 1", "1", "A self-loop does not change anything.")],
    hidden=lambda: ["2 1\n1 2\n", "3 3\n1 2\n2 3\n1 3\n", "6 3\n1 1\n2 2\n3 3\n", edges_txt("100000 99999", [(i, i + 1) for i in range(1, 100000)]),
                    edges_txt("100000 50000", _re2(31, 100000, 50000)), edges_txt("100000 200000", _re2(32, 100000, 200000)), edges_txt("100000 100000", _re2(33, 100000, 100000)),
                    edges_txt("1000 300", _re2(34, 1000, 300))],
    valid=_valid_cc,
    py="import sys\nd = sys.stdin.buffer.read().split()\nn, m = int(d[0]), int(d[1])\npar = list(range(n + 1))\n\ndef find(x):\n    while par[x] != x:\n        par[x] = par[par[x]]\n        x = par[x]\n    return x\n\ncomp = n\nfor i in range(m):\n    a = find(int(d[2 + 2 * i])); b = find(int(d[3 + 2 * i]))\n    if a != b:\n        par[a] = b\n        comp -= 1\nprint(comp)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, m; scanf("%d %d", &n, &m);
    vector<vector<int>> adj(n + 1);
    for (int i = 0; i < m; i++) { int u, v; scanf("%d %d", &u, &v); adj[u].push_back(v); adj[v].push_back(u); }
    vector<char> seen(n + 1, 0); int comps = 0;
    for (int s = 1; s <= n; s++) {                       // breadth-first search from every unvisited vertex
        if (seen[s]) continue;
        comps++; queue<int> q; q.push(s); seen[s] = 1;
        while (!q.empty()) { int u = q.front(); q.pop(); for (int v : adj[u]) if (!seen[v]) { seen[v] = 1; q.push(v); } }
    }
    printf("%d\n", comps);
}
''',
    time_complexity="O((n + m) * alpha(n))", space_complexity="O(n)"))


# ------------------------------------------------------------------ intervals
def iv_txt(iv):
    return f"{len(iv)}\n" + "".join(f"{s} {e}\n" for s, e in iv)


def _valid_iv(inp):
    ls = lines_of(inp)
    n = int(ls[0])
    ok(1 <= n <= 100000 and len(ls) == 1 + n)
    for line in ls[1:]:
        s, e = map(int, line.split())
        ok(0 <= s < e <= B)


def _riv(seed, n, hi, maxlen):
    r = rng(seed)
    out = []
    for _ in range(n):
        s = r.randint(0, hi - 1)
        out.append((s, min(hi, s + r.randint(1, maxlen))))
    return out


add(Problem(
    slug="max-non-overlapping-intervals", title="Maximum Non-Overlapping Intervals", difficulty="MEDIUM", tags=["Greedy", "Intervals", "Sorting"],
    story="You are given `n` time intervals `[start, end)`. Two intervals **overlap** if they share any moment; an interval ending exactly when another starts does **not** overlap with it. Choose as many intervals as possible so that no two chosen intervals overlap, and print how many you can choose.\n\nThe greedy rule: sort by end time and always take the interval that ends first among those compatible with what you already took.",
    input_fmt="The first line contains `n`. Each of the next `n` lines contains `start` and `end`.", output_fmt="Print the maximum number of pairwise non-overlapping intervals.",
    constraints=["`1 <= n <= 100000`", "`0 <= start < end <= 1000000000`"],
    examples=[("4\n1 3\n2 4\n3 5\n6 8", "3", "Take `[1,3)`, `[3,5)` and `[6,8)`; `[2,4)` overlaps the first two."),
              ("3\n1 5\n2 3\n4 6", "2", "`[2,3)` and `[4,6)` fit together; `[1,5)` overlaps both."),
              ("1\n1 2", "1", "A single interval.")],
    hidden=lambda: [iv_txt([(0, 1), (0, 1)]), iv_txt([(1, 2), (2, 3), (3, 4)]), iv_txt([(0, 10), (1, 2), (3, 4), (5, 6), (7, 8)]), iv_txt([(0, B)] * 5), iv_txt(_riv(41, 40, 100, 20)),
                    iv_txt(_riv(42, 100000, B, 10000)), iv_txt(_riv(43, 100000, B, 100000000)), iv_txt([(i, i + 1) for i in range(100000)])],
    valid=_valid_iv,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\niv = sorted(((int(d[2 + 2 * i]), int(d[1 + 2 * i])) for i in range(n)))\ncnt = 0\nlast = -1\nfor e, s in iv:\n    if s >= last:\n        cnt += 1\n        last = e\nprint(cnt)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; scanf("%d", &n);
    vector<pair<long long, long long>> v(n);       // (end, start)
    for (auto &p : v) scanf("%lld %lld", &p.second, &p.first);
    sort(v.begin(), v.end());
    vector<long long> ends(n); for (int i = 0; i < n; i++) ends[i] = v[i].first;
    vector<int> dp(n + 1, 0);                       // dp[i] = best count among the first i intervals (sorted by end)
    for (int i = 0; i < n; i++) {
        int j = upper_bound(ends.begin(), ends.begin() + i, v[i].second) - ends.begin();   // intervals ending at or before start
        dp[i + 1] = max(dp[i], dp[j] + 1);
    }
    printf("%d\n", dp[n]);
}
''',
    time_complexity="O(n log n)", space_complexity="O(n)"))

add(Problem(
    slug="total-covered-length", title="Total Length Covered by Intervals", difficulty="MEDIUM", tags=["Intervals", "Sorting", "Greedy"],
    story="`n` segments lie on a number line, segment `i` covering everything from `start` to `end`. Segments may overlap or nest. Print the total length of the line that is covered by **at least one** segment (overlapping parts are counted once).\n\nSort by start and merge overlapping segments, or sweep over the segment endpoints.",
    input_fmt="The first line contains `n`. Each of the next `n` lines contains `start` and `end`.", output_fmt="Print the total covered length.",
    constraints=["`1 <= n <= 100000`", "`0 <= start < end <= 1000000000`"],
    examples=[("3\n1 4\n2 6\n8 10", "7", "`[1,6]` has length 5 and `[8,10]` has length 2."),
              ("2\n0 5\n5 9", "9", "The segments touch at 5, giving `[0, 9]`."),
              ("2\n1 10\n3 4", "9", "The second segment lies inside the first.")],
    hidden=lambda: [iv_txt([(0, 1)]), iv_txt([(0, B)]), iv_txt([(0, 1), (2, 3), (4, 5)]), iv_txt([(5, 6), (0, 10), (3, 4)]), iv_txt([(0, 5), (0, 5), (0, 5)]), iv_txt(_riv(51, 50, 200, 30)),
                    iv_txt(_riv(52, 100000, B, 1000)), iv_txt(_riv(53, 100000, B, 20000000)), iv_txt([(2 * i, 2 * i + 1) for i in range(100000)])],
    valid=_valid_iv,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\niv = sorted((int(d[1 + 2 * i]), int(d[2 + 2 * i])) for i in range(n))\ntotal = 0\ncs, ce = iv[0]\nfor s, e in iv[1:]:\n    if s > ce:\n        total += ce - cs\n        cs, ce = s, e\n    else:\n        ce = max(ce, e)\ntotal += ce - cs\nprint(total)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; scanf("%d", &n);
    map<long long, int> delta;                 // +1 where a segment starts, -1 where it ends
    for (int i = 0; i < n; i++) { long long s, e; scanf("%lld %lld", &s, &e); delta[s]++; delta[e]--; }
    long long total = 0, prev = 0; int open = 0;
    for (auto &[x, d] : delta) { if (open > 0) total += x - prev; open += d; prev = x; }
    printf("%lld\n", total);
}
''',
    time_complexity="O(n log n)", space_complexity="O(n)"))


# ------------------------------------------------------------------ DP
def _valid_coin(inp):
    t = inp.split()
    n, amt = int(t[0]), int(t[1])
    ok(1 <= n <= 12 and 0 <= amt <= 10000 and len(t) == 2 + n and all(1 <= int(x) <= 10000 for x in t[2:]))


def _coin(coins, amt):
    return f"{len(coins)} {amt}\n{' '.join(map(str, coins))}\n"


add(Problem(
    slug="coin-change-minimum-coins", title="Minimum Number of Coins", difficulty="MEDIUM", tags=["Dynamic Programming"],
    story="You have an unlimited supply of coins of each given denomination. Find the **fewest** coins that add up to exactly `amount`, or print `-1` if it cannot be done. A greedy choice of the biggest coin is not always optimal (with coins 1, 3, 4 the amount 6 needs two coins `3 + 3`, not three), so use dynamic programming: `best[x] = 1 + min(best[x - c])` over all coins `c <= x`.",
    input_fmt="The first line contains `n` (number of denominations) and `amount`. The second line contains the `n` coin values.", output_fmt="Print the minimum number of coins, or `-1`. For `amount = 0` print `0`.",
    constraints=["`1 <= n <= 12`", "`1 <= coin <= 10000`", "`0 <= amount <= 10000`"],
    examples=[("3 11\n1 2 5", "3", "`5 + 5 + 1`."),
              ("1 3\n2", "-1", "Only even amounts can be built from 2."),
              ("3 6\n1 3 4", "2", "`3 + 3` beats the greedy `4 + 1 + 1`.")],
    hidden=lambda: [_coin([7], 0), _coin([1], 10000), _coin([5, 10], 3), _coin([2, 5, 10, 1], 27), _coin([186, 419, 83, 408], 6249), _coin([10000, 9999], 10000), _coin([3, 7], 11),
                    _coin([rng(61).randint(1, 400) for _ in range(12)], 9999), _coin([9973, 9967, 9949], 10000), _coin([1, 5, 6, 9], 11)],
    valid=_valid_coin,
    py="import sys\nd = sys.stdin.read().split()\nn, amt = int(d[0]), int(d[1])\ncoins = [int(x) for x in d[2:2 + n]]\nINF = 10 ** 9\nbest = [0] + [INF] * amt\nfor x in range(1, amt + 1):\n    for c in coins:\n        if c <= x and best[x - c] + 1 < best[x]:\n            best[x] = best[x - c] + 1\nprint(best[amt] if best[amt] < INF else -1)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, amt; cin >> n >> amt;
    vector<int> coins(n); for (auto &c : coins) cin >> c;
    vector<int> dist(amt + 1, -1); dist[0] = 0;       // breadth-first search over reachable amounts
    queue<int> q; q.push(0);
    while (!q.empty()) {
        int u = q.front(); q.pop();
        for (int c : coins) { long long v = (long long)u + c; if (v <= amt && dist[v] < 0) { dist[v] = dist[u] + 1; q.push((int)v); } }
    }
    cout << dist[amt] << endl;
}
''',
    time_complexity="O(amount * n)", space_complexity="O(amount)"))


def _valid_lcs(inp):
    ls = lines_of(inp)
    ok(len(ls) == 2 and all(1 <= len(x) <= 1000 and x.isascii() and x.islower() and x.isalpha() for x in ls))


def _rs(seed, n, al):
    r = rng(seed)
    return "".join(r.choice(al) for _ in range(n))


add(Problem(
    slug="longest-common-subsequence", title="Longest Common Subsequence", difficulty="MEDIUM", tags=["Dynamic Programming", "Strings"],
    story="A *subsequence* is obtained by deleting zero or more characters without changing the order of the rest (so `ace` is a subsequence of `abcde`, but `aec` is not). Print the length of the longest string that is a subsequence of **both** given strings.\n\nLet `dp[i][j]` be the answer for the first `i` characters of the first string and the first `j` of the second: if the characters match it is `dp[i-1][j-1] + 1`, otherwise `max(dp[i-1][j], dp[i][j-1])`.",
    input_fmt="Two lines: the first string, then the second string.", output_fmt="Print the length of the longest common subsequence.",
    constraints=["`1 <= |s|, |t| <= 1000`", "Both strings contain lowercase English letters."],
    examples=[("abcde\nace", "3", "`ace` is common to both."),
              ("abc\nabc", "3", "The strings are equal."),
              ("abc\ndef", "0", "No common letters.")],
    hidden=lambda: ["a\na\n", "a\nb\n", "abcbdab\nbdcaba\n", "aaaa\naa\n", "abcdef\nfedcba\n", _rs(71, 60, "abc") + "\n" + _rs(72, 70, "abc") + "\n",
                    _rs(73, 1000, "ab") + "\n" + _rs(74, 1000, "ab") + "\n", _rs(75, 1000, "abcdefghijklmnopqrstuvwxyz") + "\n" + _rs(76, 1000, "abcdefghijklmnopqrstuvwxyz") + "\n", "a" * 1000 + "\n" + "a" * 1000 + "\n"],
    valid=_valid_lcs,
    py="import sys\ns, t = sys.stdin.read().split()\nprev = [0] * (len(t) + 1)\nfor ch in s:\n    cur = [0]\n    for j, c in enumerate(t):\n        cur.append(prev[j] + 1 if ch == c else max(prev[j + 1], cur[j]))\n    prev = cur\nprint(prev[-1])\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    string s, t; cin >> s >> t;
    int n = s.size(), m = t.size();
    vector<vector<int>> dp(n + 1, vector<int>(m + 1, 0));     // full table
    for (int i = n - 1; i >= 0; i--) for (int j = m - 1; j >= 0; j--)     // suffix formulation
        dp[i][j] = (s[i] == t[j]) ? dp[i + 1][j + 1] + 1 : max(dp[i + 1][j], dp[i][j + 1]);
    cout << dp[0][0] << endl;
}
''',
    time_complexity="O(|s| * |t|)", space_complexity="O(|t|)"))


def _valid_rob(inp):
    check_arr(inp, 1, 100000, 0, 10000)


add(Problem(
    slug="house-robber-max-sum", title="Maximum Sum Without Adjacent Elements", difficulty="MEDIUM", tags=["Dynamic Programming", "Arrays"],
    story="Houses stand in a row and house `i` holds `a[i]` coins. Taking from two **adjacent** houses sets off an alarm, so you may not pick two neighbouring houses. Print the maximum total you can take.\n\nFor each house you either skip it (keep the best so far) or take it (add its value to the best of the houses up to two positions earlier).",
    input_fmt="The first line contains `n`. The second line contains `n` integers.", output_fmt="Print the maximum total.",
    constraints=["`1 <= n <= 100000`", "`0 <= a[i] <= 10000`"],
    examples=[("4\n1 2 3 1", "4", "Take houses 1 and 3: `1 + 3 = 4`."),
              ("5\n2 7 9 3 1", "12", "Take houses 1, 3 and 5: `2 + 9 + 1 = 12`."),
              ("1\n5", "5", "One house.")],
    hidden=lambda: [arr_case([0]), arr_case([3, 3]), arr_case([2, 1, 1, 2]), arr_case([10000] * 10), arr_case([rng(81).randint(0, 20) for _ in range(18)]), arr_case([rng(82).randint(0, 10000) for _ in range(20)]),
                    arr_case([rng(83).randint(0, 10000) for _ in range(100000)]), arr_case([10000] * 100000), arr_case([1, 100, 1] * 33333)],
    valid=_valid_rob,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\ntake = skip = 0\nfor x in d[1:1 + n]:\n    take, skip = skip + int(x), max(take, skip)\nprint(max(take, skip))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    vector<long long> a(n); for (auto &x : a) cin >> x;
    long long best = 0;
    if (n <= 20) {                                    // try every subset without two neighbours
        for (int mask = 0; mask < (1 << n); mask++) {
            if (mask & (mask >> 1)) continue;
            long long s = 0; for (int i = 0; i < n; i++) if (mask >> i & 1) s += a[i];
            best = max(best, s);
        }
    } else {
        vector<long long> dp(n + 2, 0);              // dp[i] = best using the first i houses
        for (int i = 1; i <= n; i++) dp[i] = max(dp[i - 1], (i >= 2 ? dp[i - 2] : 0) + a[i - 1]);
        best = dp[n];
    }
    cout << best << endl;
}
''',
    time_complexity="O(n)", space_complexity="O(1)"))


# ------------------------------------------------------------------ bits
def _valid_single(inp):
    t = inp.split()
    n = int(t[0])
    ok(1 <= n <= 99999 and n % 2 == 1 and len(t) == 1 + n)
    from collections import Counter
    c = Counter(int(x) for x in t[1:])
    ok(all(abs(v) <= B for v in c) and sorted(c.values()).count(1) == 1 and all(x in (1, 2) for x in c.values()), "exactly one value must occur once")


def _single(seed, pairs):
    r = rng(seed)
    pool = r.sample(range(-B, B), pairs + 1)
    a = pool[1:] * 2 + [pool[0]]
    r.shuffle(a)
    return arr_case(a)


add(Problem(
    slug="single-number-xor", title="The Number That Appears Once", difficulty="EASY", tags=["Bit Manipulation", "Hashing", "Arrays"],
    story="In an array of odd length every value appears **exactly twice**, except one value that appears exactly once. Find the value that appears once.\n\nA hash map of counts works, but XOR solves it with no extra memory: `x ^ x = 0` and `x ^ 0 = x`, so XOR-ing all numbers cancels every pair.",
    input_fmt="The first line contains `n`. The second line contains `n` integers.", output_fmt="Print the value that appears once.",
    constraints=["`1 <= n <= 99999`, `n` is odd", "`-1000000000 <= a[i] <= 1000000000`", "Exactly one value appears once; every other value appears exactly twice."],
    examples=[("3\n2 2 1", "1", "2 appears twice, 1 once."),
              ("5\n4 1 2 1 2", "4", "The pairs 1 and 2 cancel, leaving 4."),
              ("1\n-9", "-9", "A single element.")],
    hidden=lambda: [arr_case([0]), arr_case([5, 0, 5]), arr_case([-3, 7, -3]), arr_case([1, -1, 1, 2, 2]), _single(91, 20), _single(92, 5000), _single(93, 49999), arr_case([B, -B, B])],
    valid=_valid_single,
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nr = 0\nfor x in d[1:1 + n]:\n    r ^= int(x)\nprint(r)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; scanf("%d", &n);
    map<long long, int> cnt;
    for (int i = 0; i < n; i++) { long long x; scanf("%lld", &x); cnt[x]++; }
    for (auto &[v, c] : cnt) if (c == 1) { printf("%lld\n", v); break; }
}
''',
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug="total-set-bits-up-to-n", title="Total Set Bits From 1 to N", difficulty="HARD", tags=["Bit Manipulation", "Math"],
    story="The *set bits* of a number are the `1`s in its binary representation (`5 = 101` has two). Print the total number of set bits over all integers from `1` to `N` inclusive.\n\n`N` can be as large as `10^12`, so you cannot loop over every number. In every bit position the pattern of `0`s and `1`s repeats with a fixed period; count the ones per period and handle the partial period at the end.",
    input_fmt="One integer `N`.", output_fmt="Print the total number of set bits.",
    constraints=["`1 <= N <= 1000000000000`"],
    examples=[("3", "4", "`1 = 1`, `2 = 10`, `3 = 11` contain 1 + 1 + 2 = 4 set bits."),
              ("8", "13", "`1,2,3,4,5,6,7,8` have 1,1,2,1,2,2,3,1 set bits."),
              ("1", "1", "Only the number 1.")],
    hidden=lambda: ["2", "7", "15", "16", "17", "1000", "123456", "1000000", "549755813887", "549755813888", "999999999999", "1000000000000"],
    valid=lambda inp: ok(len(lines_of(inp)) == 1 and 1 <= int(inp) <= 10 ** 12),
    py="n = int(input())\ntotal = 0\nm = n + 1\nfor b in range(41):\n    period = 1 << (b + 1)\n    total += (m // period) * (period // 2) + max(0, m % period - period // 2)\nprint(total)\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
long long f(long long n) {                         // set bits over 0..n by splitting at the highest power of two
    if (n <= 0) return 0;
    int p = 63 - __builtin_clzll(n);
    long long pw = 1LL << p;
    return (long long)p * (pw / 2) + (n - pw + 1) + f(n - pw);
}
int main() {
    long long n; cin >> n;
    if (n <= 2000000) { long long t = 0; for (long long i = 1; i <= n; i++) t += __builtin_popcountll(i); cout << t << endl; }
    else cout << f(n) << endl;
}
''',
    time_complexity="O(log N)", space_complexity="O(1)"))


# ------------------------------------------------------------------ trie
def _valid_trie(inp):
    ls = lines_of(inp)
    n, q = map(int, ls[0].split())
    ok(1 <= n <= 100000 and 1 <= q <= 100000 and len(ls) == 3)
    w, p = ls[1].split(), ls[2].split()
    ok(len(w) == n and len(p) == q)
    ok(sum(map(len, w)) <= 200000 and sum(map(len, p)) <= 200000)
    ok(all(x.isascii() and x.islower() and x.isalpha() for x in w + p))


def _trie_case(seed, n, q, al, wl, pl):
    r = rng(seed)
    w = ["".join(r.choice(al) for _ in range(r.randint(1, wl))) for _ in range(n)]
    p = ["".join(r.choice(al) for _ in range(r.randint(1, pl))) for _ in range(q)]
    return f"{n} {q}\n{' '.join(w)}\n{' '.join(p)}\n"


add(Problem(
    slug="count-words-with-prefix", title="Count Words With a Given Prefix", difficulty="MEDIUM", tags=["Tries", "Strings", "Hashing"],
    story="A dictionary contains `n` words (repeated words count separately). Answer `q` questions: for each prefix `p`, how many dictionary words start with `p`? A word is a prefix of itself.\n\nStore the words in a *trie* where every node remembers how many words pass through it; each query then costs only the length of the prefix.",
    input_fmt="The first line contains `n` and `q`. The second line contains the `n` words. The third line contains the `q` prefixes.", output_fmt="Print `q` lines, the answer for each prefix in order.",
    constraints=["`1 <= n, q <= 100000`", "All strings are non-empty and lowercase.", "The total length of the words is at most `200000`; likewise for the prefixes."],
    examples=[("5 3\napple app apt bat ball\nap ba c", "3\n2\n0", "`apple`, `app`, `apt` start with `ap`; `bat`, `ball` start with `ba`; nothing starts with `c`."),
              ("3 2\nab ab abc\nab abc", "3\n1", "Duplicates count twice: `ab` is a prefix of `ab`, `ab` and `abc`.")],
    hidden=lambda: ["1 1\na\na\n", "1 1\na\nb\n", "1 1\nab\nabc\n", "3 3\nzz z zzz\nz zz zzz\n", _trie_case(101, 30, 30, "ab", 6, 4), _trie_case(102, 50000, 50000, "abc", 3, 3),
                    _trie_case(103, 100000, 100000, "abcdefghijklmnopqrstuvwxyz", 2, 2), "2 2\n" + "a" * 100000 + " " + "a" * 99999 + "\n" + "a" * 100000 + " " + "a" * 5 + "\n"],
    valid=_valid_trie,
    py="import sys\nd = sys.stdin.read().split()\nn, q = int(d[0]), int(d[1])\nroot = {}\nfor w in d[2:2 + n]:\n    node = root\n    for ch in w:\n        node = node.setdefault(ch, {})\n        node[0] = node.get(0, 0) + 1\nout = []\nfor p in d[2 + n:2 + n + q]:\n    node = root\n    for ch in p:\n        node = node.get(ch)\n        if node is None:\n            break\n    out.append(0 if node is None else node[0])\nprint('\\n'.join(map(str, out)))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, q; cin >> n >> q;
    vector<string> w(n); for (auto &s : w) cin >> s;
    sort(w.begin(), w.end());                       // words starting with p form a contiguous block in sorted order
    while (q--) {
        string p; cin >> p;
        auto lo = lower_bound(w.begin(), w.end(), p);
        string hi = p; hi.push_back('{');           // '{' sorts right after 'z', so [p, p+'{') holds every extension of p
        auto up = lower_bound(w.begin(), w.end(), hi);
        printf("%d\n", (int)(up - lo));
    }
}
''',
    time_complexity="O(total length)", space_complexity="O(total length)"))


# ------------------------------------------------------------------ number theory
add(Problem(
    slug="count-primes-up-to-n", title="Count Primes Up To N", difficulty="MEDIUM", tags=["Number Theory", "Math"],
    story="A *prime* is an integer greater than 1 whose only divisors are 1 and itself. Print how many primes are `<= N`.\n\nTesting every number separately is too slow for `N = 10^7`. Use the **sieve of Eratosthenes**: start with every number marked prime, then for each prime `p` cross out `p*p, p*p + p, ...`.",
    input_fmt="One integer `N`.", output_fmt="Print the number of primes not exceeding `N`.",
    constraints=["`1 <= N <= 10000000`"],
    examples=[("10", "4", "The primes are 2, 3, 5, 7."), ("2", "1", "2 is the smallest prime."), ("1", "0", "1 is not prime.")],
    hidden=lambda: ["3", "4", "30", "97", "100", "1000", "99991", "100000", "1000000", "9999991", "10000000"],
    valid=lambda inp: ok(len(lines_of(inp)) == 1 and 1 <= int(inp) <= 10 ** 7),
    py="n = int(input())\nif n < 2:\n    print(0)\nelse:\n    s = bytearray([1]) * (n + 1)\n    s[0] = s[1] = 0\n    for i in range(2, int(n ** 0.5) + 1):\n        if s[i]:\n            s[i * i::i] = bytes(len(range(i * i, n + 1, i)))\n    print(sum(s))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    if (n <= 200000) {                              // trial division
        int cnt = 0;
        for (int x = 2; x <= n; x++) { bool pr = true; for (int d = 2; (long long)d * d <= x; d++) if (x % d == 0) { pr = false; break; } cnt += pr; }
        cout << cnt << endl;
    } else {                                        // linear sieve: every composite is removed once by its smallest prime
        vector<int> primes; vector<char> comp(n + 1, 0);
        for (int i = 2; i <= n; i++) {
            if (!comp[i]) primes.push_back(i);
            for (int p : primes) { if ((long long)i * p > n) break; comp[i * p] = 1; if (i % p == 0) break; }
        }
        cout << primes.size() << endl;
    }
}
''',
    time_complexity="O(N log log N)", space_complexity="O(N)"))


def _valid_pow(inp):
    t = inp.split()
    ok(len(t) == 3)
    a, b, m = map(int, t)
    ok(0 <= a <= 10 ** 18 and 0 <= b <= 10 ** 18 and 1 <= m <= B)


add(Problem(
    slug="modular-exponentiation", title="Modular Exponentiation", difficulty="MEDIUM", tags=["Number Theory", "Math", "Recursion"],
    story="Compute `a^b mod m`. The exponent `b` can be as large as `10^18`, so you cannot multiply `a` by itself `b` times. Use *binary exponentiation*: `a^b = (a^(b/2))^2` for even `b` and `a * a^(b-1)` for odd `b`, reducing modulo `m` after every multiplication so that numbers stay small.\n\nBy convention `a^0 = 1`, so for `b = 0` the answer is `1 mod m` (which is `0` when `m = 1`).",
    input_fmt="One line with three integers `a`, `b` and `m`.", output_fmt="Print `a^b mod m`.",
    constraints=["`0 <= a <= 10^18`", "`0 <= b <= 10^18`", "`1 <= m <= 10^9`"],
    examples=[("2 10 1000", "24", "`2^10 = 1024`, and `1024 mod 1000 = 24`."),
              ("5 0 7", "1", "Anything to the power 0 is 1."),
              ("10 3 1", "0", "Every number is 0 modulo 1.")],
    hidden=lambda: ["0 0 5", "0 5 7", "1 1000000000000000000 13", "2 1000000000000000000 1000000000", "123456789012345678 987654321098765432 999999937", "999999999999999999 999999999999999999 999999999",
                    "7 1 2", "3 200 999999937", "10 18 1000000000", "1000000000000000000 1000000000000000000 1000000000"],
    valid=_valid_pow,
    py="a, b, m = map(int, input().split())\nprint(pow(a, b, m))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
typedef unsigned long long ull;
ull power(ull a, ull b, ull m) {                    // recursive halving
    if (b == 0) return 1 % m;
    ull h = power(a, b / 2, m);
    ull r = h * h % m;
    return (b & 1) ? r * (a % m) % m : r;
}
int main() {
    ull a, b, m; cin >> a >> b >> m;
    cout << power(a % m, b, m) << endl;
}
''',
    time_complexity="O(log b)", space_complexity="O(log b) recursion (O(1) iteratively)"))


# ------------------------------------------------------------------ matrix
def mat_txt(m):
    return f"{len(m)} {len(m[0])}\n" + "\n".join(" ".join(map(str, row)) for row in m) + "\n"


def _valid_mat(inp):
    ls = lines_of(inp)
    r, c = map(int, ls[0].split())
    ok(1 <= r <= 500 and 1 <= c <= 500 and len(ls) == 1 + r)
    ok(all(len(x.split()) == c and all(abs(int(v)) <= B for v in x.split()) for x in ls[1:]))


def _rmat(seed, r, c):
    g = rng(seed)
    return mat_txt([[g.randint(-B, B) for _ in range(c)] for _ in range(r)])


add(Problem(
    slug="spiral-matrix-order", title="Spiral Order of a Matrix", difficulty="MEDIUM", tags=["Matrices", "Arrays"],
    story="Print all elements of an `R x C` matrix in **spiral order**: start at the top-left corner, go right along the first row, then down the last column, then left along the last row, then up the first column, and keep spiralling inward until every element has been printed exactly once.",
    input_fmt="The first line contains `R` and `C`. Each of the next `R` lines contains `C` integers.", output_fmt="Print the `R * C` elements in spiral order, separated by spaces.",
    constraints=["`1 <= R, C <= 500`", "`-1000000000 <= value <= 1000000000`"],
    examples=[("3 3\n1 2 3\n4 5 6\n7 8 9", "1 2 3 6 9 8 7 4 5", "Right along row 1, down column 3, left along row 3, up to 4, then the centre 5."),
              ("1 4\n1 2 3 4", "1 2 3 4", "A single row."),
              ("3 1\n1\n2\n3", "1 2 3", "A single column."),
              ("2 3\n1 2 3\n4 5 6", "1 2 3 6 5 4", "After going around the outside nothing is left.")],
    hidden=lambda: ["1 1\n7\n", "2 2\n1 2\n3 4\n", "3 4\n1 2 3 4\n5 6 7 8\n9 10 11 12\n", "4 3\n1 2 3\n4 5 6\n7 8 9\n10 11 12\n", _rmat(111, 5, 7), _rmat(112, 7, 5), _rmat(113, 1, 500), _rmat(114, 500, 1), _rmat(115, 500, 500), _rmat(116, 499, 500)],
    valid=_valid_mat,
    py="import sys\nd = sys.stdin.read().split()\nr, c = int(d[0]), int(d[1])\nm = [d[2 + i * c:2 + (i + 1) * c] for i in range(r)]\ntop, bot, left, right = 0, r - 1, 0, c - 1\nout = []\nwhile top <= bot and left <= right:\n    out += m[top][left:right + 1]\n    for i in range(top + 1, bot + 1):\n        out.append(m[i][right])\n    if top < bot:\n        out += m[bot][left:right][::-1]\n    if left < right:\n        for i in range(bot - 1, top, -1):\n            out.append(m[i][left])\n    top += 1; bot -= 1; left += 1; right -= 1\nprint(' '.join(out))\n",
    cpp=r'''#include <bits/stdc++.h>
using namespace std;
int main() {
    int r, c; cin >> r >> c;
    vector<vector<string>> m(r, vector<string>(c));
    for (auto &row : m) for (auto &x : row) cin >> x;
    vector<vector<char>> seen(r, vector<char>(c, 0));
    int dx[4] = {0, 1, 0, -1}, dy[4] = {1, 0, -1, 0}, x = 0, y = 0, dir = 0;
    for (int k = 0; k < r * c; k++) {                  // walk, turning right whenever the next cell is outside or already used
        cout << m[x][y] << (k + 1 < r * c ? ' ' : '\n');
        seen[x][y] = 1;
        int nx = x + dx[dir], ny = y + dy[dir];
        if (nx < 0 || nx >= r || ny < 0 || ny >= c || seen[nx][ny]) { dir = (dir + 1) % 4; nx = x + dx[dir]; ny = y + dy[dir]; }
        x = nx; y = ny;
    }
}
''',
    time_complexity="O(R * C)", space_complexity="O(1) extra"))
