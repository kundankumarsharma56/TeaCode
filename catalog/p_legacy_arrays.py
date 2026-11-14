"""Legacy array problems (slugs created by migration V6, rewritten in place)."""
from lib import Problem
from common import rng, arr_case, check_arr

B = 10 ** 9
IN_ARR = "The first line contains an integer `n`. The second line contains `n` integers separated by single spaces."
LEG = "original-signal-"


def _v(nmin, nmax, lo, hi, extras=0):
    return lambda inp: check_arr(inp, nmin, nmax, lo, hi, extras)


def _rand_arr(seed, n, lo, hi):
    r = rng(seed)
    return [r.randint(lo, hi) for _ in range(n)]


PROBLEMS = []
add = PROBLEMS.append

add(Problem(
    slug=LEG + "array-total", title="Array Total", difficulty="EASY", tags=["Arrays", "Math"], legacy=True,
    story="You are given a list of integers. Compute the sum of all of them.\n\nThe sum can be larger than a 32-bit integer, so use a 64-bit type in languages that need one.",
    input_fmt=IN_ARR, output_fmt="Print one integer: the sum of the `n` values.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("5\n2 4 6 8 10", "30", "2 + 4 + 6 + 8 + 10 = 30."),
        ("4\n-3 7 0 2", "6", "Negative values and zero are included: -3 + 7 + 0 + 2 = 6."),
        ("1\n-9", "-9", "A single element is its own sum."),
    ],
    hidden=lambda: [arr_case([5]), arr_case([-1, -2, -3]), arr_case([0, 0, 0, 0]), arr_case([B] * 5),
                    arr_case([-B] * 3 + [B]), arr_case(_rand_arr(1, 1000, -B, B)), arr_case([B] * 100000)],
    valid=_v(1, 100000, -B, B),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nprint(sum(int(x) for x in d[1:1 + n]))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;long long s=0;for(int i=0;i<n;i++){long long x;cin>>x;s+=x;}cout<<s<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "peak-value", title="Peak Value", difficulty="EASY", tags=["Arrays"], legacy=True,
    story="Find the largest value in a list of integers.",
    input_fmt=IN_ARR, output_fmt="Print the largest of the `n` values.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("5\n3 9 2 9 4", "9", "9 is the largest value; it appears twice, which does not change the answer."),
        ("3\n-7 -3 -12", "-3", "All values are negative; -3 is the largest because it is closest to zero."),
        ("1\n42", "42", "A single element is the maximum."),
    ],
    hidden=lambda: [arr_case([0]), arr_case([-B, -B]), arr_case([B, -B, 0]), arr_case([1, 2, 3, 4, 5, 6]),
                    arr_case([6, 5, 4, 3, 2, 1]), arr_case(_rand_arr(2, 5000, -B, B)), arr_case([-B] * 99999 + [-B + 1])],
    valid=_v(1, 100000, -B, B),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nprint(max(int(x) for x in d[1:1 + n]))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;long long m=LLONG_MIN;for(int i=0;i<n;i++){long long x;cin>>x;m=max(m,x);}cout<<m<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "even-count", title="Even Count", difficulty="EASY", tags=["Arrays", "Math"], legacy=True,
    story="Count how many of the given integers are even. Zero is even, and negative numbers can be even too.",
    input_fmt=IN_ARR, output_fmt="Print the number of even values.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("6\n1 2 3 4 5 6", "3", "2, 4 and 6 are even."),
        ("5\n0 -2 7 9 11", "2", "0 and -2 are even; 7, 9 and 11 are odd."),
        ("3\n1 3 5", "0", "No value is even."),
    ],
    hidden=lambda: [arr_case([0]), arr_case([-1]), arr_case([2, 4, 6, 8]), arr_case([-4, -3, -2, -1, 0, 1, 2, 3]),
                    arr_case([B, -B, B - 1]), arr_case(_rand_arr(4, 3000, -B, B)), arr_case([2] * 100000)],
    valid=_v(1, 100000, -B, B),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nprint(sum(1 for x in d[1:1 + n] if int(x) % 2 == 0))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;int c=0;for(int i=0;i<n;i++){long long x;cin>>x;if(x%2==0)c++;}cout<<c<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "array-reversal", title="Array Reversal", difficulty="EASY", tags=["Arrays"], legacy=True,
    story="Print a list of integers in reverse order: the last element first, the first element last.",
    input_fmt=IN_ARR, output_fmt="Print the `n` values in reverse order on one line, separated by single spaces.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("5\n1 2 3 4 5", "5 4 3 2 1", "The order of the five values is flipped."),
        ("4\n-1 0 0 7", "7 0 0 -1", "Repeated values keep their count; only the order changes."),
        ("1\n9", "9", "A single element is unchanged."),
    ],
    hidden=lambda: [arr_case([0]), arr_case([1, 2]), arr_case([2, 1]), arr_case([-B, 0, B]), arr_case([7, 7, 7]),
                    arr_case(_rand_arr(5, 1000, -B, B)), arr_case(list(range(1, 50001)))],
    valid=_v(1, 100000, -B, B),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nprint(' '.join(reversed(d[1:1 + n])))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;vector<long long>a(n);for(auto&x:a)cin>>x;for(int i=n-1;i>=0;i--){cout<<a[i]<<(i?' ':'\\n');}}\n",
    time_complexity="O(n)", space_complexity="O(n)"))

add(Problem(
    slug=LEG + "circular-shift", title="Circular Shift", difficulty="MEDIUM", tags=["Arrays", "Math"], legacy=True,
    story="Rotate an array to the left by `k` positions. Every element moves `k` places toward the front, and the elements that fall off the front reappear at the back in their original order.\n\n`k` may be larger than `n`; rotating by `n` positions returns the original array.",
    input_fmt="The first line contains `n`. The second line contains `n` integers. The third line contains `k`.",
    output_fmt="Print the rotated array on one line, separated by single spaces.",
    constraints=["`1 <= n <= 100000`", "`0 <= k <= 1000000000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("5\n1 2 3 4 5\n2", "3 4 5 1 2", "The first two elements (1 and 2) move to the back."),
        ("4\n10 20 30 40\n6", "30 40 10 20", "`k = 6` is larger than `n = 4`; rotating by 6 is the same as rotating by 6 mod 4 = 2."),
        ("3\n7 8 9\n0", "7 8 9", "Rotating by zero positions changes nothing."),
    ],
    hidden=lambda: [arr_case([5], 3), arr_case([1, 2, 3], 3), arr_case([1, 2, 3], 4), arr_case([1, 2, 3, 4], 1),
                    arr_case([-5, 6, -7, 8, 9], B), arr_case(_rand_arr(6, 2000, -B, B), 1234567),
                    arr_case(list(range(100000)), 99999)],
    valid=_v(1, 100000, -B, B, 1),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\na = d[1:1 + n]\nk = int(d[1 + n]) % n\nprint(' '.join(a[k:] + a[:k]))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;vector<long long>a(n);for(auto&x:a)cin>>x;long long k;cin>>k;k%=n;rotate(a.begin(),a.begin()+k,a.end());for(int i=0;i<n;i++)cout<<a[i]<<(i+1<n?' ':'\\n');}\n",
    time_complexity="O(n)", space_complexity="O(n)"))

add(Problem(
    slug=LEG + "target-frequency", title="Target Frequency", difficulty="EASY", tags=["Arrays", "Hashing"], legacy=True,
    story="Count how many times a target value `x` occurs in a list of integers.",
    input_fmt="The first line contains `n`. The second line contains `n` integers. The third line contains the target `x`.",
    output_fmt="Print the number of positions `i` with `a[i] = x`.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i], x <= 1000000000`"],
    examples=[
        ("7\n1 2 2 3 2 5 2\n2", "4", "The value 2 appears at four positions."),
        ("4\n5 6 7 8\n9", "0", "The target does not occur, so the answer is 0."),
        ("3\n-1 -1 -1\n-1", "3", "Every element equals the (negative) target."),
    ],
    hidden=lambda: [arr_case([5], 5), arr_case([5], 6), arr_case([0, 0, 1], 0), arr_case([B, -B, B], B),
                    arr_case([1, 2, 3, 4, 5], 3), arr_case(_rand_arr(7, 3000, -5, 5), 2), arr_case([4] * 100000, 4)],
    valid=_v(1, 100000, -B, B, 1),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nx = int(d[1 + n])\nprint(sum(1 for v in d[1:1 + n] if int(v) == x))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;vector<long long>a(n);for(auto&v:a)cin>>v;long long x;cin>>x;cout<<count(a.begin(),a.end(),x)<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "distinct-values", title="Distinct Values", difficulty="EASY", tags=["Arrays", "Hashing"], legacy=True,
    story="Count how many different values occur in a list of integers. A value that appears several times is counted once.",
    input_fmt=IN_ARR, output_fmt="Print the number of distinct values.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("6\n4 4 2 2 2 9", "3", "The distinct values are 4, 2 and 9."),
        ("4\n1 2 3 4", "4", "All values are different."),
        ("5\n7 7 7 7 7", "1", "All values are the same."),
    ],
    hidden=lambda: [arr_case([0]), arr_case([1, -1, 1, -1]), arr_case([B, -B, B, -B, 0]), arr_case([1, 2, 3, 2, 1]),
                    arr_case(_rand_arr(8, 4000, -50, 50)), arr_case(_rand_arr(9, 50000, -B, B)), arr_case(list(range(100000)))],
    valid=_v(1, 100000, -B, B),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nprint(len(set(int(x) for x in d[1:1 + n])))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;vector<long long>a(n);for(auto&v:a)cin>>v;sort(a.begin(),a.end());cout<<unique(a.begin(),a.end())-a.begin()<<endl;}\n",
    time_complexity="O(n) with hashing, O(n log n) with sorting", space_complexity="O(n)"))

add(Problem(
    slug=LEG + "ascending-check", title="Ascending Check", difficulty="EASY", tags=["Arrays"], legacy=True,
    story="Decide whether a list is sorted in non-decreasing order, i.e. every element is greater than or equal to the one before it. Equal neighbours are allowed.",
    input_fmt=IN_ARR, output_fmt="Print `YES` if the list is non-decreasing, otherwise print `NO`.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("5\n1 2 2 5 9", "YES", "Each element is at least as large as the previous one; the repeated 2 is allowed."),
        ("4\n3 4 2 8", "NO", "4 is followed by the smaller value 2."),
        ("1\n5", "YES", "A list with one element is trivially sorted."),
    ],
    hidden=lambda: [arr_case([2, 1]), arr_case([1, 2]), arr_case([5, 5, 5, 5]), arr_case([-B, 0, B]), arr_case([B, 0, -B]),
                    arr_case(sorted(_rand_arr(10, 5000, -B, B))), arr_case(sorted(_rand_arr(11, 5000, -B, B)) + [-B]),
                    arr_case(list(range(100000)))],
    valid=_v(1, 100000, -B, B),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\na = [int(x) for x in d[1:1 + n]]\nprint('YES' if all(a[i] <= a[i + 1] for i in range(n - 1)) else 'NO')\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;vector<long long>a(n);for(auto&v:a)cin>>v;cout<<(is_sorted(a.begin(),a.end())?\"YES\":\"NO\")<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "running-totals", title="Running Totals", difficulty="MEDIUM", tags=["Arrays", "Prefix Sums"], legacy=True,
    story="For a list `a`, its prefix sums are `p[0] = a[0]`, `p[1] = a[0] + a[1]`, and in general `p[i] = a[0] + ... + a[i]`. Print all prefix sums.",
    input_fmt=IN_ARR, output_fmt="Print the `n` prefix sums on one line, separated by single spaces.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`", "Prefix sums can exceed 32 bits."],
    examples=[
        ("5\n1 2 3 4 5", "1 3 6 10 15", "1, 1+2, 1+2+3, 1+2+3+4, 1+2+3+4+5."),
        ("4\n5 -2 0 3", "5 3 3 6", "The running total goes down after -2 and stays the same after 0."),
        ("1\n-4", "-4", "With one element the prefix sum is the element."),
    ],
    hidden=lambda: [arr_case([0]), arr_case([B, B, B]), arr_case([-B, -B, -B]), arr_case([1, -1, 1, -1]),
                    arr_case(_rand_arr(12, 2000, -B, B)), arr_case([B] * 100000)],
    valid=_v(1, 100000, -B, B),
    py="import sys\nfrom itertools import accumulate\nd = sys.stdin.read().split()\nn = int(d[0])\nprint(' '.join(map(str, accumulate(int(x) for x in d[1:1 + n]))))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;long long s=0;for(int i=0;i<n;i++){long long x;cin>>x;s+=x;cout<<s<<(i+1<n?' ':'\\n');}}\n",
    time_complexity="O(n)", space_complexity="O(1) besides the output"))

add(Problem(
    slug=LEG + "runner-up-value", title="Runner-Up Value", difficulty="MEDIUM", tags=["Arrays"], legacy=True,
    story="Find the second-largest **distinct** value in a list. Duplicates of the largest value do not count as the runner-up: if the maximum is 9 and it appears twice, the runner-up is the next smaller different value.\n\nIf there is no second distinct value, print `NONE`.",
    input_fmt=IN_ARR, output_fmt="Print the second-largest distinct value, or `NONE` if it does not exist.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("5\n4 9 9 7 1", "7", "The largest value is 9 (twice). The largest value below it is 7."),
        ("3\n5 5 5", "NONE", "Only one distinct value exists."),
        ("2\n-3 -8", "-8", "The maximum is -3, so the runner-up is -8."),
    ],
    hidden=lambda: [arr_case([1]), arr_case([1, 2]), arr_case([2, 1]), arr_case([B, B, -B]), arr_case([0, 0, 0, 1]),
                    arr_case(_rand_arr(13, 3000, -B, B)), arr_case(_rand_arr(14, 60000, -3, 3))],
    valid=_v(1, 100000, -B, B),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\ns = sorted(set(int(x) for x in d[1:1 + n]), reverse=True)\nprint(s[1] if len(s) > 1 else 'NONE')\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;long long m1=LLONG_MIN,m2=LLONG_MIN;bool h1=false,h2=false;for(int i=0;i<n;i++){long long x;cin>>x;if(!h1||x>m1){if(h1&&x!=m1){m2=m1;h2=true;}m1=x;h1=true;}else if(x<m1&&(!h2||x>m2)){m2=x;h2=true;}}if(h2)cout<<m2<<endl;else cout<<\"NONE\"<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "rising-streak", title="Rising Streak", difficulty="MEDIUM", tags=["Arrays"], legacy=True,
    story="A *streak* is a block of consecutive positions where every value is strictly larger than the one before it. Find the length of the longest streak. A single element is a streak of length 1.",
    input_fmt=IN_ARR, output_fmt="Print the length of the longest strictly increasing contiguous segment.",
    constraints=["`1 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`"],
    examples=[
        ("7\n1 2 3 1 2 3 4", "4", "The segment `1 2 3 4` at the end has length 4; the first streak `1 2 3` has length 3."),
        ("5\n5 4 3 2 1", "1", "No value is larger than its predecessor, so every streak has length 1."),
        ("6\n1 1 2 2 3 3", "2", "Equal neighbours break a streak. The longest streaks are `1 2` and `2 3`, each of length 2."),
    ],
    hidden=lambda: [arr_case([7]), arr_case([1, 2]), arr_case([2, 1]), arr_case([1, 2, 3, 4, 5]), arr_case([3, 3, 3]),
                    arr_case([-B, B, -B, B]), arr_case(_rand_arr(15, 4000, -10, 10)), arr_case(list(range(100000)))],
    valid=_v(1, 100000, -B, B),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\na = [int(x) for x in d[1:1 + n]]\nbest = cur = 1\nfor i in range(1, n):\n    cur = cur + 1 if a[i] > a[i - 1] else 1\n    best = max(best, cur)\nprint(best)\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;vector<long long>a(n);for(auto&v:a)cin>>v;int best=1,cur=1;for(int i=1;i<n;i++){if(a[i]>a[i-1])cur++;else cur=1;best=max(best,cur);}cout<<best<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "pair-reachability", title="Pair Reachability", difficulty="MEDIUM", tags=["Arrays", "Hashing"], legacy=True,
    story="Given a list of integers and a target `t`, decide whether there are two **different positions** `i != j` whose values add up to `t`. The two values may be equal, but they must come from two different positions.",
    input_fmt="The first line contains `n`. The second line contains `n` integers. The third line contains `t`.",
    output_fmt="Print `YES` if such a pair exists, otherwise `NO`.",
    constraints=["`2 <= n <= 100000`", "`-1000000000 <= a[i] <= 1000000000`", "`-2000000000 <= t <= 2000000000`"],
    examples=[
        ("5\n3 8 1 6 2\n9", "YES", "The values 3 (position 1) and 6 (position 4) are at different positions and 3 + 6 = 9."),
        ("3\n5 1 7\n10", "NO", "5 + 5 would need the single 5 twice; no two different positions add up to 10."),
        ("4\n5 5 1 2\n10", "YES", "Two different positions both hold 5, and 5 + 5 = 10."),
    ],
    hidden=lambda: [arr_case([1, 2], 3), arr_case([1, 2], 4), arr_case([0, 0], 0), arr_case([-B, B], 0), arr_case([B, B], 2 * B),
                    arr_case([B, B, B], -2 * B), arr_case(_rand_arr(16, 3000, 0, B), 3), arr_case(list(range(1, 100001)), 199999),
                    arr_case(list(range(1, 100001)), 200001)],
    valid=_v(2, 100000, -B, B, 1),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\na = [int(x) for x in d[1:1 + n]]\nt = int(d[1 + n])\nseen = set()\nok = False\nfor x in a:\n    if t - x in seen:\n        ok = True\n        break\n    seen.add(x)\nprint('YES' if ok else 'NO')\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;vector<long long>a(n);for(auto&v:a)cin>>v;long long t;cin>>t;sort(a.begin(),a.end());int i=0,j=n-1;bool ok=false;while(i<j){long long s=a[i]+a[j];if(s==t){ok=true;break;}if(s<t)i++;else j--;}cout<<(ok?\"YES\":\"NO\")<<endl;}\n",
    time_complexity="O(n) with hashing, O(n log n) with sorting and two pointers", space_complexity="O(n)"))
