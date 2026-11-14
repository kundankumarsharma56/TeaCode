"""Legacy string / number / matrix problems (slugs created by migration V6, rewritten in place)."""
from lib import Problem
from common import rng, arr_case, check_arr, lines_of

LEG = "original-signal-"
B = 10 ** 9
PROBLEMS = []
add = PROBLEMS.append


def one_line(maxlen, pred, minlen=1):
    def v(inp):
        ls = lines_of(inp)
        assert len(ls) == 1, "expected exactly one line"
        assert minlen <= len(ls[0]) <= maxlen, f"length {len(ls[0])}"
        assert pred(ls[0]), "character set violated"
    return v


def num(maxv, minv=0):
    def v(inp):
        t = inp.split()
        assert len(t) == 1
        assert minv <= int(t[0]) <= maxv
    return v


def letters(s):
    return all(c.isascii() and c.isalpha() for c in s)


add(Problem(
    slug=LEG + "mirror-word", title="Mirror Word", difficulty="EASY", tags=["Strings"], legacy=True,
    story="A word is a *mirror word* (a palindrome) if it reads the same from left to right and from right to left. Decide whether the given word is one. Upper and lower case letters are different characters: `A` is not equal to `a`.",
    input_fmt="One line containing a single word made of English letters.",
    output_fmt="Print `YES` if the word is a mirror word, otherwise `NO`.",
    constraints=["`1 <= length <= 100000`", "The word contains only the letters `a-z` and `A-Z`."],
    examples=[
        ("level", "YES", "`level` reversed is `level`."),
        ("Level", "NO", "Reversed it is `leveL`; the first letter `L` differs from the last letter `l` because comparison is case-sensitive."),
        ("a", "YES", "A one-letter word is the same in both directions."),
    ],
    hidden=lambda: ["ab", "aa", "abba", "abcba", "abca", "Aa", "z" * 100000, "a" * 49999 + "b" + "a" * 49999 + "c"],
    valid=one_line(100000, letters),
    py="import sys\ns = sys.stdin.readline().strip()\nprint('YES' if s == s[::-1] else 'NO')\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){string s;cin>>s;bool ok=true;for(size_t i=0,j=s.size()-1;i<j;i++,j--)if(s[i]!=s[j]){ok=false;break;}cout<<(ok?\"YES\":\"NO\")<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "vowel-tally", title="Vowel Tally", difficulty="EASY", tags=["Strings"], legacy=True,
    story="Count the vowels in a line of text. The vowels are `a`, `e`, `i`, `o`, `u`, in either upper or lower case. The letter `y` is not a vowel. Spaces, digits and punctuation are not vowels.",
    input_fmt="One line of text (it may contain spaces, digits and punctuation).",
    output_fmt="Print the number of vowels in the line.",
    constraints=["`1 <= length <= 100000`", "The line contains printable ASCII characters only."],
    examples=[
        ("Hello World", "3", "The vowels are `e`, `o` and `o`."),
        ("rhythm", "0", "`y` is not a vowel, so there are none."),
        ("AEIOU aeiou", "10", "Upper and lower case vowels are both counted: 5 + 5."),
    ],
    hidden=lambda: ["x", "a", "Why? Because I said so!", "12345 !!! ???", "The quick brown fox jumps over the lazy dog.",
                    "UuOoIiEeAa", "bcdfghjklmnpqrstvwxyz", "ae " * 30000],
    valid=one_line(100000, lambda s: all(32 <= ord(c) < 127 for c in s)),
    py="import sys\ns = sys.stdin.readline().rstrip('\\n')\nprint(sum(1 for c in s.lower() if c in 'aeiou'))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){string s;getline(cin,s);int c=0;for(char ch:s){ch=tolower((unsigned char)ch);if(ch=='a'||ch=='e'||ch=='i'||ch=='o'||ch=='u')c++;}cout<<c<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "word-order-flip", title="Word Order Flip", difficulty="EASY", tags=["Strings"], legacy=True,
    story="A line contains words separated by single spaces. Print the same words in reverse order. The letters inside each word keep their original order; only the order of the words is reversed.",
    input_fmt="One line of words separated by single spaces, with no leading or trailing spaces.",
    output_fmt="Print the words in reverse order, separated by single spaces.",
    constraints=["`1 <= number of words <= 50000`", "Each word is made of lowercase letters and digits, length `1` to `20`."],
    examples=[
        ("one two three", "three two one", "The three words are listed from last to first."),
        ("hello", "hello", "A single word is unchanged."),
        ("red green blue yellow", "yellow blue green red", "Words are reversed as whole units, not letter by letter."),
    ],
    hidden=lambda: ["a b", "b a", "x1 y2 z3", "same same same", "abc abc cba", " ".join(f"w{i}" for i in range(1, 20001)),
                    "the quick brown fox jumps over the lazy dog"],
    valid=one_line(2000000, lambda s: all(1 <= len(w) <= 20 and all(c.islower() or c.isdigit() for c in w) for w in s.split(" ")) and "  " not in s and s == s.strip()),
    py="import sys\nprint(' '.join(sys.stdin.readline().split()[::-1]))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){vector<string>w;string s;while(cin>>s)w.push_back(s);for(int i=(int)w.size()-1;i>=0;i--)cout<<w[i]<<(i?' ':'\\n');}\n",
    time_complexity="O(n)", space_complexity="O(n)"))

add(Problem(
    slug=LEG + "digit-total", title="Digit Total", difficulty="EASY", tags=["Math"], legacy=True,
    story="Add up the decimal digits of a non-negative integer. For example the digits of `9990` add up to `9 + 9 + 9 + 0 = 27`.",
    input_fmt="One non-negative integer `n`, written without leading zeros.",
    output_fmt="Print the sum of the decimal digits of `n`.",
    constraints=["`0 <= n <= 10^18`"],
    examples=[
        ("12345", "15", "1 + 2 + 3 + 4 + 5 = 15."),
        ("0", "0", "The only digit is 0."),
        ("9990", "27", "9 + 9 + 9 + 0 = 27."),
    ],
    hidden=lambda: ["7", "10", "100000", "999999999999999999", "1000000000000000000", "123456789012345678", "1111111111", "90000000000000009"],
    valid=num(10 ** 18),
    py="n = input().strip()\nprint(sum(int(c) for c in n))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){unsigned long long n;cin>>n;int s=0;do{s+=n%10;n/=10;}while(n);cout<<s<<endl;}\n",
    time_complexity="O(log n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "greatest-divider", title="Greatest Divider", difficulty="EASY", tags=["Math", "Number Theory"], legacy=True,
    story="The greatest common divisor (GCD) of two non-negative integers is the largest positive integer that divides both. If one of the numbers is `0`, the GCD is the other number.",
    input_fmt="One line with two integers `a` and `b` separated by a space.",
    output_fmt="Print `gcd(a, b)`.",
    constraints=["`0 <= a, b <= 10^18`", "`a` and `b` are not both zero."],
    examples=[
        ("48 18", "6", "The divisors of 48 and 18 in common are 1, 2, 3 and 6; the greatest is 6."),
        ("17 5", "1", "17 and 5 are coprime."),
        ("0 9", "9", "Every positive integer divides 0, so the GCD of 0 and 9 is 9."),
    ],
    hidden=lambda: ["1 1", "9 0", "100 75", "270 192", "1000000000000000000 1", "1000000000000000000 999999999999999999",
                    "600851475143 6857", "123456789012345678 987654321098765432"],
    valid=lambda inp: (lambda t: (len(t) == 2 and all(0 <= int(x) <= 10 ** 18 for x in t) and (int(t[0]) or int(t[1])) or (_ for _ in ()).throw(AssertionError("bad"))))(inp.split()),
    py="import math\na, b = map(int, input().split())\nprint(math.gcd(a, b))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){unsigned long long a,b;cin>>a>>b;while(b){unsigned long long t=a%b;a=b;b=t;}cout<<a<<endl;}\n",
    time_complexity="O(log(min(a, b)))", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "prime-signal", title="Prime Signal", difficulty="EASY", tags=["Math", "Number Theory"], legacy=True,
    story="A *prime* is an integer greater than 1 whose only positive divisors are 1 and itself. Decide whether `n` is prime. Values below 2 are not prime.",
    input_fmt="One integer `n`.",
    output_fmt="Print `YES` if `n` is prime, otherwise `NO`.",
    constraints=["`-1000000 <= n <= 1000000000000`"],
    examples=[
        ("29", "YES", "29 has no divisor between 2 and 5 (its square root is about 5.4)."),
        ("1", "NO", "1 is below 2, so it is not prime."),
        ("91", "NO", "91 = 7 x 13, so it has a divisor other than 1 and itself (it only looks prime)."),
        ("2", "YES", "2 is the smallest prime."),
    ],
    hidden=lambda: ["0", "-7", "3", "4", "97", "100", "7919", "999983", "1000000007", "999999999989", "1000000000000", "999999937"],
    valid=num(10 ** 12, -10 ** 6),
    py="n = int(input())\nif n < 2:\n    print('NO')\nelse:\n    i = 2\n    ok = True\n    while i * i <= n:\n        if n % i == 0:\n            ok = False\n            break\n        i += 1\n    print('YES' if ok else 'NO')\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){long long n;cin>>n;if(n<2){cout<<\"NO\"<<endl;return 0;}if(n<4){cout<<\"YES\"<<endl;return 0;}if(n%2==0){cout<<\"NO\"<<endl;return 0;}for(long long i=3;i*i<=n;i+=2)if(n%i==0){cout<<\"NO\"<<endl;return 0;}cout<<\"YES\"<<endl;}\n",
    time_complexity="O(sqrt(n))", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "factorial-value", title="Factorial Value", difficulty="EASY", tags=["Math"], legacy=True,
    story="The factorial of `n`, written `n!`, is the product `1 x 2 x ... x n`. By definition `0! = 1`. Print `n!`.",
    input_fmt="One integer `n`.", output_fmt="Print `n!`.",
    constraints=["`0 <= n <= 20` (so that `n!` fits in a signed 64-bit integer)"],
    examples=[
        ("5", "120", "5! = 1 x 2 x 3 x 4 x 5 = 120."),
        ("0", "1", "By definition 0! = 1 (the empty product)."),
        ("20", "2432902008176640000", "The largest allowed input; the result still fits in 64 bits."),
    ],
    hidden=lambda: [str(i) for i in (1, 2, 3, 4, 6, 7, 10, 12, 13, 15, 19)],
    valid=num(20),
    py="n = int(input())\nr = 1\nfor i in range(2, n + 1):\n    r *= i\nprint(r)\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;unsigned long long r=1;for(int i=2;i<=n;i++)r*=i;cout<<r<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "fibonacci-position", title="Fibonacci Position", difficulty="EASY", tags=["Math", "Dynamic Programming"], legacy=True,
    story="The Fibonacci numbers are defined by `F(0) = 0`, `F(1) = 1` and `F(i) = F(i-1) + F(i-2)` for `i >= 2`. Print `F(n)`.",
    input_fmt="One integer `n`.", output_fmt="Print `F(n)`.",
    constraints=["`0 <= n <= 45`"],
    examples=[
        ("10", "55", "The sequence starts 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55; the entry at index 10 is 55."),
        ("0", "0", "`F(0)` is defined as 0."),
        ("45", "1134903170", "The largest allowed input; the value is bigger than 2^30 but still fits in a signed 32-bit integer."),
    ],
    hidden=lambda: [str(i) for i in (1, 2, 3, 4, 5, 20, 30, 40, 44)],
    valid=num(45),
    py="n = int(input())\na, b = 0, 1\nfor _ in range(n):\n    a, b = b, a + b\nprint(a)\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;vector<long long>f(n+2);f[0]=0;f[1]=1;for(int i=2;i<=n;i++)f[i]=f[i-1]+f[i-2];cout<<f[n]<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "leap-year-test", title="Leap-Year Test", difficulty="EASY", tags=["Math"], legacy=True,
    story="In the Gregorian calendar a year is a leap year if it is divisible by 4, except that years divisible by 100 are not leap years unless they are also divisible by 400.",
    input_fmt="One integer `year`.", output_fmt="Print `YES` if the year is a leap year, otherwise `NO`.",
    constraints=["`1 <= year <= 9999`"],
    examples=[
        ("2000", "YES", "2000 is divisible by 400, so it is a leap year."),
        ("1900", "NO", "1900 is divisible by 100 but not by 400."),
        ("2024", "YES", "2024 is divisible by 4 and not by 100."),
        ("2023", "NO", "2023 is not divisible by 4."),
    ],
    hidden=lambda: [str(i) for i in (1, 4, 100, 400, 1600, 1700, 2100, 2400, 1996, 2019, 9999, 9996)],
    valid=num(9999, 1),
    py="y = int(input())\nprint('YES' if (y % 4 == 0 and y % 100 != 0) or y % 400 == 0 else 'NO')\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int y;cin>>y;bool leap=(y%400==0)||(y%4==0&&y%100!=0);cout<<(leap?\"YES\":\"NO\")<<endl;}\n",
    time_complexity="O(1)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "binary-ones", title="Binary Ones", difficulty="EASY", tags=["Bit Manipulation"], legacy=True,
    story="Count the `1` bits in the binary representation of a non-negative integer. For example `13` is `1101` in binary, which contains three `1` bits.",
    input_fmt="One non-negative integer `n`.", output_fmt="Print the number of `1` bits in `n`.",
    constraints=["`0 <= n <= 10^18`"],
    examples=[
        ("13", "3", "13 = 1101 in binary: three 1 bits."),
        ("0", "0", "Zero has no 1 bits."),
        ("1023", "10", "1023 = 1111111111 in binary (ten 1 bits)."),
    ],
    hidden=lambda: ["1", "2", "3", "8", "255", "256", "1000000", "576460752303423487", "1000000000000000000", "1099511627776"],
    valid=num(10 ** 18),
    py="print(bin(int(input())).count('1'))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){unsigned long long n;cin>>n;int c=0;while(n){c+=n&1;n>>=1;}cout<<c<<endl;}\n",
    time_complexity="O(log n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "binary-display", title="Binary Display", difficulty="EASY", tags=["Bit Manipulation", "Math"], legacy=True,
    story="Print a non-negative integer in binary, without leading zeros. Zero is printed as a single `0`.",
    input_fmt="One non-negative integer `n`.", output_fmt="Print the binary representation of `n`.",
    constraints=["`0 <= n <= 10^18`"],
    examples=[
        ("10", "1010", "10 = 8 + 2, so bits 3 and 1 are set: `1010`."),
        ("0", "0", "Zero is written as `0`."),
        ("255", "11111111", "255 = 2^8 - 1: eight 1 bits."),
    ],
    hidden=lambda: ["1", "2", "5", "64", "1023", "1024", "123456789", "1000000000000000000", "576460752303423488"],
    valid=num(10 ** 18),
    py="print(bin(int(input()))[2:])\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){unsigned long long n;cin>>n;if(n==0){cout<<0<<endl;return 0;}string s;while(n){s+=char('0'+(n&1));n>>=1;}reverse(s.begin(),s.end());cout<<s<<endl;}\n",
    time_complexity="O(log n)", space_complexity="O(log n)"))

add(Problem(
    slug=LEG + "bracket-balance", title="Bracket Balance", difficulty="EASY", tags=["Stacks", "Strings"], legacy=True,
    story="A string of parentheses is *balanced* if every `(` can be paired with a later `)` and every `)` with an earlier `(`, so that pairs are properly nested. Decide whether the given string is balanced.",
    input_fmt="One line containing only the characters `(` and `)`.",
    output_fmt="Print `YES` if the string is balanced, otherwise `NO`.",
    constraints=["`1 <= length <= 100000`"],
    examples=[
        ("(()())", "YES", "Each `(` is closed in the correct order."),
        (")(", "NO", "The first character closes a bracket that was never opened."),
        ("(()", "NO", "One `(` is never closed."),
        ("()()", "YES", "Two separate balanced pairs."),
    ],
    hidden=lambda: ["()", "((", "))", "(())", "())(", "()(()", "((()))()", "(" * 50000 + ")" * 50000, "(" * 50000 + ")" * 49999 + "(", ")" + "()" * 49999],
    valid=one_line(100000, lambda s: set(s) <= set("()")),
    py="s = input().strip()\nd = 0\nok = True\nfor c in s:\n    d += 1 if c == '(' else -1\n    if d < 0:\n        ok = False\n        break\nprint('YES' if ok and d == 0 else 'NO')\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){string s;cin>>s;vector<char>st;bool ok=true;for(char c:s){if(c=='(')st.push_back(c);else{if(st.empty()){ok=false;break;}st.pop_back();}}cout<<((ok&&st.empty())?\"YES\":\"NO\")<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1) with a counter, O(n) with an explicit stack"))

add(Problem(
    slug=LEG + "longest-token", title="Longest Token", difficulty="EASY", tags=["Strings"], legacy=True,
    story="A line contains words separated by single spaces. Print the length of the longest word. If several words share the longest length, the length is printed once.",
    input_fmt="One line of words separated by single spaces.",
    output_fmt="Print one integer: the length of the longest word.",
    constraints=["`1 <= number of words <= 50000`", "Each word consists of 1 to 100 letters or digits."],
    examples=[
        ("the quick brown fox", "5", "`quick` and `brown` both have 5 letters, so the answer is 5 (printed once)."),
        ("a", "1", "The only word has length 1."),
        ("go to the zoo", "3", "`the` and `zoo` tie with 3 letters; the length 3 is printed once."),
    ],
    hidden=lambda: ["ab c", "x" * 100, "a bb ccc dddd eeeee", "one two three four", "abc def ghi", " ".join(["w"] * 30000), "k9 k99 k999"],
    valid=one_line(5100000, lambda s: all(1 <= len(w) <= 100 and w.isalnum() for w in s.split(" ")) and "  " not in s and s == s.strip()),
    py="print(max(len(w) for w in input().split()))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){string s;size_t m=0;while(cin>>s)m=max(m,s.size());cout<<m<<endl;}\n",
    time_complexity="O(n)", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "digital-root-sum", title="Digital Root Sum", difficulty="EASY", tags=["Math"], legacy=True,
    story="Repeatedly replace a number by the sum of its decimal digits until a single digit remains. Print that digit (the *digital root*).\n\nFor example `9875 -> 9+8+7+5 = 29 -> 2+9 = 11 -> 1+1 = 2`.",
    input_fmt="One non-negative integer `n`.", output_fmt="Print the single digit that remains.",
    constraints=["`0 <= n <= 10^18`"],
    examples=[
        ("9875", "2", "9875 -> 29 -> 11 -> 2."),
        ("0", "0", "Zero is already a single digit."),
        ("7", "7", "A single digit stays as it is."),
        ("999999999999999999", "9", "Eighteen nines: digit sum 162 -> 9."),
    ],
    hidden=lambda: ["9", "10", "18", "38", "12345", "1000000000000000000", "123456789", "98765432109876543", "555555555"],
    valid=num(10 ** 18),
    py="n = input().strip()\nwhile len(n) > 1:\n    n = str(sum(int(c) for c in n))\nprint(n)\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){unsigned long long n;cin>>n;if(n==0){cout<<0<<endl;return 0;}cout<<(1+(n-1)%9)<<endl;}\n",
    time_complexity="O(log n) by repeated digit sums, O(1) with the modulo-9 identity", space_complexity="O(1)"))

add(Problem(
    slug=LEG + "missing-member", title="Missing Member", difficulty="MEDIUM", tags=["Arrays", "Math"], legacy=True,
    story="The numbers `1, 2, ..., n` were written down, but one of them is missing. You are given the other `n - 1` numbers, in any order and without repeats. Find the missing one.",
    input_fmt="The first line contains `n`. The second line contains the `n - 1` remaining numbers separated by single spaces.",
    output_fmt="Print the missing number.",
    constraints=["`2 <= n <= 100000`", "The given numbers are distinct and lie between 1 and `n`."],
    examples=[
        ("5\n1 2 4 5", "3", "Among 1..5 the number 3 is absent."),
        ("2\n2", "1", "With n = 2 only the number 2 is given, so 1 is missing."),
        ("4\n4 1 3", "2", "The numbers can come in any order; 2 is missing."),
    ],
    hidden=lambda: ["2\n1", "3\n3 1", "3\n2 3", "10\n10 9 8 7 6 5 4 3 1", "6\n1 2 3 4 5",
                    "100000\n" + " ".join(map(str, range(2, 100001))), "100000\n" + " ".join(map(str, range(1, 100000)))],
    valid=lambda inp: (lambda t: (2 <= int(t[0]) <= 100000 and len(t) == int(t[0]) and len(set(t[1:])) == len(t) - 1 and all(1 <= int(x) <= int(t[0]) for x in t[1:])) or (_ for _ in ()).throw(AssertionError("bad")))(inp.split()),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nprint(n * (n + 1) // 2 - sum(int(x) for x in d[1:n]))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;vector<bool>seen(n+1,false);for(int i=0;i<n-1;i++){int x;cin>>x;seen[x]=true;}for(int i=1;i<=n;i++)if(!seen[i]){cout<<i<<endl;return 0;}}\n",
    time_complexity="O(n)", space_complexity="O(1) with the sum formula, O(n) with a seen array"))

add(Problem(
    slug=LEG + "sorted-merge", title="Sorted Merge", difficulty="MEDIUM", tags=["Arrays", "Two Pointers", "Sorting"], legacy=True,
    story="You are given two lists that are each already sorted in non-decreasing order. Merge them into one sorted list without sorting the combined data from scratch: walk through both lists with two pointers and always take the smaller front element.",
    input_fmt="The first line contains `n` and `m`. The second line contains the `n` numbers of the first list. The third line contains the `m` numbers of the second list.",
    output_fmt="Print the merged list in non-decreasing order, separated by single spaces.",
    constraints=["`1 <= n, m <= 100000`", "`-1000000000 <= value <= 1000000000`", "Both lists are sorted in non-decreasing order."],
    examples=[
        ("3 3\n1 4 9\n2 3 10", "1 2 3 4 9 10", "Taking the smaller front element each time gives 1, 2, 3, 4, 9, 10."),
        ("2 3\n-5 -5\n-5 0 5", "-5 -5 -5 0 5", "Equal values from both lists are all kept."),
        ("1 1\n7\n7", "7 7", "Two single-element lists."),
    ],
    hidden=lambda: ["1 1\n1\n2", "1 1\n2\n1", "2 2\n1 2\n3 4", "2 2\n3 4\n1 2", "3 1\n1 1 1\n1",
                    "3 3\n-1000000000 0 1000000000\n-1000000000 0 1000000000",
                    "50000 50000\n" + " ".join(map(str, range(0, 100000, 2))) + "\n" + " ".join(map(str, range(1, 100000, 2)))],
    valid=lambda inp: (lambda ls: (lambda n, m, a, b: (len(a) == n and len(b) == m and a == sorted(a) and b == sorted(b) and 1 <= n <= 100000 and 1 <= m <= 100000) or (_ for _ in ()).throw(AssertionError("bad")))(int(ls[0].split()[0]), int(ls[0].split()[1]), [int(x) for x in ls[1].split()], [int(x) for x in ls[2].split()]))(lines_of(inp)),
    py="import sys\nd = sys.stdin.read().split()\nn, m = int(d[0]), int(d[1])\na = list(map(int, d[2:2 + n]))\nb = list(map(int, d[2 + n:2 + n + m]))\ni = j = 0\nout = []\nwhile i < n and j < m:\n    if a[i] <= b[j]:\n        out.append(a[i]); i += 1\n    else:\n        out.append(b[j]); j += 1\nout += a[i:] + b[j:]\nprint(' '.join(map(str, out)))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n,m;cin>>n>>m;vector<long long>a(n),b(m),c;for(auto&x:a)cin>>x;for(auto&x:b)cin>>x;c.reserve(n+m);merge(a.begin(),a.end(),b.begin(),b.end(),back_inserter(c));for(size_t i=0;i<c.size();i++)cout<<c[i]<<(i+1<c.size()?' ':'\\n');}\n",
    time_complexity="O(n + m)", space_complexity="O(n + m) for the output"))

add(Problem(
    slug=LEG + "matrix-diagonal", title="Matrix Diagonal", difficulty="MEDIUM", tags=["Arrays", "Matrices"], legacy=True,
    story="Given a square matrix, compute the sum of its **main diagonal**: the cells whose row index equals their column index (top-left to bottom-right).",
    input_fmt="The first line contains `n`. The next `n` lines each contain `n` integers separated by single spaces.",
    output_fmt="Print the sum of the main diagonal.",
    constraints=["`1 <= n <= 500`", "`-1000000000 <= value <= 1000000000`"],
    examples=[
        ("3\n1 2 3\n4 5 6\n7 8 9", "15", "The diagonal cells are 1, 5 and 9: 1 + 5 + 9 = 15."),
        ("2\n-1 5\n7 -4", "-5", "The diagonal cells are -1 and -4. The other diagonal (5 and 7) is not used."),
        ("1\n8", "8", "A 1 x 1 matrix: the diagonal is the single cell."),
    ],
    hidden=lambda: ["1\n0", "1\n-1000000000", "2\n1 2\n3 4", "3\n0 0 0\n0 0 0\n0 0 0", "3\n1000000000 1 1\n1 1000000000 1\n1 1 1000000000",
                    "4\n1 2 3 4\n5 6 7 8\n9 10 11 12\n13 14 15 16",
                    "500\n" + "\n".join(" ".join(str((i * 31 + j * 17) % 2001 - 1000) for j in range(500)) for i in range(500))],
    valid=lambda inp: (lambda t: (1 <= int(t[0]) <= 500 and len(t) == 1 + int(t[0]) ** 2) or (_ for _ in ()).throw(AssertionError("bad")))(inp.split()),
    py="import sys\nd = sys.stdin.read().split()\nn = int(d[0])\nprint(sum(int(d[1 + i * n + i]) for i in range(n)))\n",
    cpp="#include <bits/stdc++.h>\nusing namespace std;\nint main(){int n;cin>>n;long long s=0;for(int i=0;i<n;i++)for(int j=0;j<n;j++){long long x;cin>>x;if(i==j)s+=x;}cout<<s<<endl;}\n",
    time_complexity="O(n^2) to read the input, O(n) to sum the diagonal", space_complexity="O(1)"))
