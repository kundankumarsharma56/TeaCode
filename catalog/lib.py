"""TeaCode problem catalog: authoring helpers, executable validation and SQL generation.

A problem is authored once (statement, examples with explanations, hidden-test generator, and two independent
reference solutions: Python and C++). `validate()` EXECUTES both solutions on every public and hidden input, requires
identical output, checks every example's stated output against the solutions, and checks duplicates. Nothing is
marked verified unless it was executed here.
"""
from __future__ import annotations

import hashlib
import json
import os
import re
import subprocess
import sys
import tempfile
from dataclasses import dataclass, field
from typing import Callable, Optional

ROOT = os.path.dirname(os.path.abspath(__file__))
BUILD = os.path.join(tempfile.gettempdir(), "teacode-catalog-build")
os.makedirs(BUILD, exist_ok=True)

DIFFICULTIES = ("EASY", "MEDIUM", "HARD")

# name -> slug. Existing tags keep their slugs (V6 created arrays, bits, math, matrices, stacks, strings).
TAGS = {
    "Arrays": "arrays", "Strings": "strings", "Hashing": "hashing", "Sorting": "sorting",
    "Binary Search": "binary-search", "Two Pointers": "two-pointers", "Sliding Window": "sliding-window",
    "Linked Lists": "linked-lists", "Stacks": "stacks", "Queues": "queues", "Recursion": "recursion",
    "Backtracking": "backtracking", "Trees": "trees", "Binary Search Trees": "binary-search-trees",
    "Heaps": "heaps", "Graphs": "graphs", "BFS": "bfs", "DFS": "dfs", "Greedy": "greedy",
    "Dynamic Programming": "dynamic-programming", "Bit Manipulation": "bit-manipulation", "Math": "math",
    "Number Theory": "number-theory", "Prefix Sums": "prefix-sums", "Intervals": "intervals", "Tries": "tries",
    "Matrices": "matrices", "Union Find": "union-find", "Topological Sort": "topological-sort",
}


@dataclass
class Problem:
    slug: str
    title: str
    difficulty: str
    tags: list
    story: str                      # markdown: the problem statement proper
    input_fmt: str                  # markdown
    output_fmt: str                 # markdown
    constraints: list               # list of markdown bullet strings
    examples: list                  # [(input, output, explanation)]
    hidden: object                  # list[str] or callable -> list[str]
    py: str                         # complete Python 3 program (stdin -> stdout)
    cpp: str                        # complete C++17 program, written independently of `py`
    time_complexity: str
    space_complexity: str
    valid: Optional[Callable[[str], None]] = None   # raises AssertionError when an input violates the constraints
    legacy: bool = False            # slug already exists from migration V6 (updated in place)
    time_limit: float = 2.0
    hidden_inputs: list = field(default_factory=list)

    # ---- derived text -------------------------------------------------------------------------------------------
    def description(self) -> str:
        parts = [f"## Problem\n\n{self.story.strip()}", f"## Input\n\n{self.input_fmt.strip()}",
                 f"## Output\n\n{self.output_fmt.strip()}",
                 "## Constraints\n\n" + "\n".join(f"- {c}" for c in self.constraints)]
        ex = []
        for i, (inp, out, why) in enumerate(self.examples, 1):
            ex.append(f"### Example {i}\n\n**Input**\n```text\n{inp.strip()}\n```\n**Output**\n```text\n{out.strip()}\n```\n"
                      f"**Explanation:** {why.strip()}")
        parts.append("## Examples\n\n" + "\n\n".join(ex))
        parts.append(f"## Expected complexity\n\n- Time: `{self.time_complexity}`\n- Auxiliary space: `{self.space_complexity}`")
        return "\n\n".join(parts) + "\n"


# ---------------------------------------------------------------------------------------------------------------
# Starter code (stdin/stdout templates). These are skeletons that compile/run and print nothing.
# ---------------------------------------------------------------------------------------------------------------
STARTER = {
    "python": "import sys\n\n\ndef main():\n    data = sys.stdin.read().split()\n    # TODO: parse the input described in the problem and print the answer.\n\n\nmain()\n",
    "java": "import java.io.*;\nimport java.util.*;\n\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));\n        // TODO: read the input described in the problem and print the answer.\n    }\n}\n",
    "c": "#include <stdio.h>\n\nint main(void) {\n    /* TODO: read the input described in the problem with scanf and print the answer. */\n    return 0;\n}\n",
    "cpp": "#include <bits/stdc++.h>\nusing namespace std;\n\nint main() {\n    ios::sync_with_stdio(false);\n    cin.tie(nullptr);\n    // TODO: read the input described in the problem and print the answer.\n    return 0;\n}\n",
    "javascript": "const data = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\n// TODO: parse the input described in the problem and print the answer with console.log.\n",
    "typescript": "import * as fs from 'fs';\n\nconst data: string[] = fs.readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\n// TODO: parse the input described in the problem and print the answer with console.log.\n",
    "csharp": "using System;\nusing System.Collections.Generic;\n\nclass Program\n{\n    static void Main()\n    {\n        string text = Console.In.ReadToEnd();\n        // TODO: parse the input described in the problem and print the answer.\n    }\n}\n",
    "php": "<?php\n$data = preg_split('/\\s+/', trim(stream_get_contents(STDIN)), -1, PREG_SPLIT_NO_EMPTY);\n// TODO: parse the input described in the problem and print the answer.\n",
    "ruby": "data = STDIN.read.split\n# TODO: parse the input described in the problem and print the answer.\n",
    "go": "package main\n\nimport (\n\t\"bufio\"\n\t\"fmt\"\n\t\"os\"\n)\n\nfunc main() {\n\treader := bufio.NewReader(os.Stdin)\n\twriter := bufio.NewWriter(os.Stdout)\n\tdefer writer.Flush()\n\t_ = reader\n\t_ = fmt.Fprint\n\t// TODO: read the input described in the problem and print the answer.\n}\n",
    "r": "con <- file(\"stdin\")\ndata <- scan(con, what = character(), quiet = TRUE)\nclose(con)\n# TODO: parse the input described in the problem and print the answer.\n",
    "kotlin": "fun main() {\n    val text = System.`in`.bufferedReader().readText()\n    // TODO: parse the input described in the problem and print the answer.\n}\n",
    "rust": "use std::io::{self, Read};\n\nfn main() {\n    let mut text = String::new();\n    io::stdin().read_to_string(&mut text).unwrap();\n    // TODO: parse the input described in the problem and print the answer.\n}\n",
    "swift": "import Foundation\n\nlet text = String(decoding: FileHandle.standardInput.readDataToEndOfFile(), as: UTF8.self)\n// TODO: parse the input described in the problem and print the answer.\n",
    "dart": "import 'dart:io';\n\nvoid main() {\n  final text = stdin.readLineSync() ?? '';\n  // TODO: parse the input described in the problem and print the answer.\n}\n",
}


# ---------------------------------------------------------------------------------------------------------------
# Execution
# ---------------------------------------------------------------------------------------------------------------
def _h(s: str) -> str:
    return hashlib.sha256(s.encode()).hexdigest()[:16]


def run_python(src: str, inp: str, timeout: float = 10) -> tuple:
    path = os.path.join(BUILD, f"py_{_h(src)}.py")
    if not os.path.exists(path):
        open(path, "w").write(src)
    p = subprocess.run([sys.executable, "-I", path], input=inp.encode(), capture_output=True, timeout=timeout)
    return p.returncode, p.stdout.decode(), p.stderr.decode()


def compile_cpp(src: str) -> str:
    exe = os.path.join(BUILD, f"cpp_{_h(src)}")
    if not os.path.exists(exe):
        path = exe + ".cpp"
        open(path, "w").write(src)
        p = subprocess.run(["g++", "-O2", "-std=c++17", "-Wall", "-o", exe, path], capture_output=True)
        if p.returncode != 0:
            raise RuntimeError("C++ compile failed:\n" + p.stderr.decode())
    return exe


def run_cpp(src: str, inp: str, timeout: float = 10) -> tuple:
    exe = compile_cpp(src)
    p = subprocess.run([exe], input=inp.encode(), capture_output=True, timeout=timeout)
    return p.returncode, p.stdout.decode(), p.stderr.decode()


def tokens(s: str) -> list:
    return s.split()


def norm_text(s: str) -> str:
    return re.sub(r"[^a-z0-9 ]+", " ", s.lower()).strip()


def title_key(t: str) -> str:
    return re.sub(r"[^a-z0-9]+", "", t.lower())


def jaccard(a: str, b: str) -> float:
    A, B = set(norm_text(a).split()), set(norm_text(b).split())
    return len(A & B) / max(1, len(A | B))


def get_hidden(p: Problem) -> list:
    h = p.hidden() if callable(p.hidden) else list(p.hidden)
    return [x if x.endswith("\n") else x + "\n" for x in h]


@dataclass
class Result:
    problem: Problem
    issues: list = field(default_factory=list)
    expected: dict = field(default_factory=dict)      # input -> expected output
    py_ms: float = 0.0
    cpp_checked: bool = False
    tests_run: int = 0


def validate(problems: list) -> tuple:
    """Executes every reference solution. Returns (results, global_issues)."""
    import time
    results, glob = [], []
    slugs, titles = {}, {}
    for p in problems:
        r = Result(p)
        results.append(r)
        bad = r.issues.append
        # ---- metadata -------------------------------------------------------------------------------------------
        if not re.fullmatch(r"[a-z0-9]+(-[a-z0-9]+)*", p.slug) or len(p.slug) > 80:
            bad("invalid slug")
        if p.slug in slugs:
            bad(f"duplicate slug (also {slugs[p.slug]})")
        slugs[p.slug] = p.title
        k = title_key(p.title)
        if k in titles:
            bad(f"duplicate title (same as {titles[k]})")
        titles[k] = p.slug
        if p.difficulty not in DIFFICULTIES:
            bad("invalid difficulty")
        if not p.tags or any(t not in TAGS for t in p.tags):
            bad(f"missing or unknown tags {p.tags}")
        for fld in ("story", "input_fmt", "output_fmt", "time_complexity", "space_complexity"):
            if len(getattr(p, fld).strip()) < 3:
                bad(f"missing {fld}")
        if len(p.constraints) < 1:
            bad("missing constraints")
        if any("see " in c.lower() and "statement" in c.lower() for c in p.constraints):
            bad("placeholder constraints")
        # ---- examples ---------------------------------------------------------------------------------------------
        if len(p.examples) < 2:
            bad(f"needs at least 2 examples, has {len(p.examples)}")
        if len({e[0].strip() for e in p.examples}) != len(p.examples):
            bad("examples are not distinct")
        for i, e in enumerate(p.examples, 1):
            if len(e) != 3 or len(e[2].strip()) < 10:
                bad(f"example {i} lacks an explanation")
        # ---- tests ------------------------------------------------------------------------------------------------
        try:
            hidden = get_hidden(p)
        except Exception as exc:  # noqa: BLE001
            bad(f"hidden generator failed: {exc}")
            continue
        p.hidden_inputs = hidden
        pub = [e[0].strip() + "\n" for e in p.examples]
        if len(hidden) < 6:
            bad(f"needs at least 6 hidden tests, has {len(hidden)}")
        if len(set(hidden)) != len(hidden):
            bad("duplicate hidden inputs")
        if set(hidden) & set(pub):
            bad("a hidden test equals a public example")
        if p.valid:
            for n, inp in enumerate(pub + hidden):
                try:
                    p.valid(inp)
                except AssertionError as exc:
                    bad(f"input #{n} violates constraints: {exc}")
        # ---- execute both references -----------------------------------------------------------------------------
        try:
            from concurrent.futures import ThreadPoolExecutor

            def both(inp):
                t0 = time.time()
                a = run_python(p.py, inp)
                dt = time.time() - t0
                return inp, a, run_cpp(p.cpp, inp), dt

            compile_cpp(p.cpp)
            with ThreadPoolExecutor(max_workers=8) as pool:
                runs = list(pool.map(both, pub + hidden))
            worst = 0.0
            for inp, (rc, out, err), (rc2, out2, err2), dt in runs:
                worst = max(worst, dt)
                if rc != 0:
                    bad(f"python reference failed (rc={rc}): {err[-200:]}")
                    break
                if rc2 != 0:
                    bad(f"C++ reference failed (rc={rc2}): {err2[-200:]}")
                    break
                if tokens(out) != tokens(out2):
                    bad(f"python and C++ disagree on a test: {tokens(out)[:6]} vs {tokens(out2)[:6]}")
                    break
                if not out.strip():
                    bad("empty expected output")
                    break
                r.expected[inp] = out.strip()
                r.tests_run += 1
            r.py_ms = worst * 1000
            r.cpp_checked = True
        except subprocess.TimeoutExpired:
            bad("a reference solution timed out")
        except Exception as exc:  # noqa: BLE001
            bad(f"execution error: {exc}")
        # ---- examples must show what the solutions print ----------------------------------------------------------
        for i, (inp, out, _) in enumerate(p.examples, 1):
            got = r.expected.get(inp.strip() + "\n")
            if got is not None and tokens(got) != tokens(out):
                bad(f"example {i} states output {tokens(out)[:6]} but the reference prints {tokens(got)[:6]}")
    # ---- cross-problem duplicate detection -----------------------------------------------------------------------
    for i, a in enumerate(problems):
        for b in problems[i + 1:]:
            if jaccard(a.story, b.story) > 0.7:
                glob.append(f"near-duplicate statements: {a.slug} ~ {b.slug} ({jaccard(a.story, b.story):.2f})")
            if set(a.hidden_inputs) and set(a.hidden_inputs) == set(b.hidden_inputs):
                glob.append(f"identical hidden test suites: {a.slug} == {b.slug}")
            if a.py.strip() == b.py.strip():
                glob.append(f"identical reference solutions: {a.slug} == {b.slug}")
    return results, glob


# ---------------------------------------------------------------------------------------------------------------
# SQL generation (Flyway migration). Idempotent: problems are upserted by slug and their dependent rows replaced.
# ---------------------------------------------------------------------------------------------------------------
def q(s: Optional[str]) -> str:
    if s is None:
        return "NULL"
    return "'" + s.replace("\\", "\\\\").replace("'", "''") + "'"


MAX_STORED_TEST_CHARS = 350000  # keeps the migration a reasonable size; larger tests are still executed by build.py


def sql_for(results: list, legacy_all_slugs: list, versions: dict) -> str:
    out = []
    w = out.append
    ps = [r.problem for r in results]
    w("-- V9: curated, validated problem catalog.\n--\n"
      "-- Why: V6 contained 510 entries that were only 30 distinct problems (each repeated 17 times with a different\n"
      "-- 'workshop' prefix), with one example, a placeholder constraint text, three tests of which one was a sample, no starter\n"
      "-- code and no reference solutions. This migration:\n"
      "--   1. archives the 480 duplicate copies (kept, not deleted, so any submission that points at them survives);\n"
      "--   2. rewrites the 30 distinct legacy problems in place (same slug) with full statements, >= 2 examples,\n"
      "--      real constraints, >= 2 sample tests and independent hidden tests;\n"
      "--   3. adds new original problems across the core algorithm topics;\n"
      "--   4. adds starter code for every language and verified reference solutions (Python, C++).\n"
      "-- Every expected output below was produced by executing the reference solutions (see catalog/REPORT.md).\n"
      "-- Re-running is safe: problems are upserted by slug and their tests/tags/starter code are replaced.\n")
    w("-- Tags (the legacy 'Bits' tag is renamed so the filter list has one bit-manipulation topic).")
    w("UPDATE problem_tags SET name = 'Bit Manipulation', slug = 'bit-manipulation' WHERE slug = 'bits'\n"
      "  AND NOT EXISTS (SELECT 1 FROM (SELECT id FROM problem_tags WHERE slug = 'bit-manipulation') t);")
    for name, slug in TAGS.items():
        w(f"INSERT INTO problem_tags (name, slug) VALUES ({q(name)}, {q(slug)}) ON DUPLICATE KEY UPDATE name = VALUES(name);")
    w("")
    canon = ", ".join(q(p.slug) for p in ps if p.legacy)
    w("-- 1. Archive the duplicate legacy copies. Only rows created by V6 (slug original-*, source LOCAL) are touched.")
    w("UPDATE problems SET visibility = 'ARCHIVED'\n WHERE source = 'LOCAL' AND slug LIKE 'original-%'\n   AND slug NOT IN (" + canon + ");\n")
    for r in results:
        p = r.problem
        w(f"-- ===== {p.slug} ({p.difficulty}) =====")
        w("INSERT INTO problems (title, slug, description, difficulty, constraints_text, input_format, output_format, comparison_mode,\n"
          "  float_tolerance, time_limit_seconds, memory_limit_kb, visibility, source, statement_status, execution_model, rating)\n"
          f"VALUES ({q(p.title)}, {q(p.slug)}, {q(p.description())}, {q(p.difficulty)}, {q(chr(10).join('- ' + c for c in p.constraints))},\n"
          f"  {q(p.input_fmt.strip())}, {q(p.output_fmt.strip())}, 'TOKEN', NULL, {p.time_limit:.2f}, 262144, 'PUBLISHED', 'LOCAL', 'AVAILABLE', 'STDIN', NULL)\n"
          "ON DUPLICATE KEY UPDATE title = VALUES(title), description = VALUES(description), difficulty = VALUES(difficulty),\n"
          "  constraints_text = VALUES(constraints_text), input_format = VALUES(input_format), output_format = VALUES(output_format),\n"
          "  comparison_mode = 'TOKEN', float_tolerance = NULL, time_limit_seconds = VALUES(time_limit_seconds),\n"
          "  memory_limit_kb = VALUES(memory_limit_kb), visibility = 'PUBLISHED', statement_status = 'AVAILABLE',\n"
          "  execution_model = 'STDIN', rating = NULL;")
        sl = q(p.slug)
        w(f"DELETE tc FROM test_cases tc JOIN problems p ON p.id = tc.problem_id WHERE p.slug = {sl};")
        w(f"DELETE m FROM problem_tag_map m JOIN problems p ON p.id = m.problem_id WHERE p.slug = {sl};")
        w(f"DELETE s FROM problem_starter_code s JOIN problems p ON p.id = s.problem_id WHERE p.slug = {sl};")
        w(f"DELETE rs FROM reference_solutions rs JOIN problems p ON p.id = rs.problem_id WHERE p.slug = {sl};")
        w("INSERT INTO problem_tag_map (problem_id, tag_id)\nSELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug IN ("
          + ", ".join(q(TAGS[t]) for t in p.tags) + f") WHERE p.slug = {sl};")
        # Multi-row INSERT ... SELECT form that works on MySQL 8.0/8.4 without derived-table column naming issues.
        all_tests = list(enumerate([e[0].strip() + chr(10) for e in p.examples] + p.hidden_inputs))
        stored = [(i, k) for i, k in all_tests if i < len(p.examples) or len(k) + len(r.expected[k]) <= MAX_STORED_TEST_CHARS]
        omitted = len(all_tests) - len(stored)
        w("INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)\nSELECT p.id, v.i, v.o, v.s, v.n FROM problems p JOIN (\n  "
          + "\n  UNION ALL ".join(
              f"SELECT {q(k)} AS i, {q(r.expected[k])} AS o, {1 if idx < len(p.examples) else 0} AS s, {idx} AS n"
              for idx, k in stored)
          + f"\n) v WHERE p.slug = {sl};")
        w("INSERT INTO problem_starter_code (problem_id, language, code)\nSELECT p.id, v.l, v.c FROM problems p JOIN (\n  "
          + "\n  UNION ALL ".join(f"SELECT {q(lang)} AS l, {q(code)} AS c" for lang, code in STARTER.items())
          + f"\n) v WHERE p.slug = {sl};")
        n_tests = len(p.examples) + len(p.hidden_inputs)
        note = f" {omitted} oversized hidden test(s) were executed in validation but are not stored in the migration (size cap)." if omitted else ""
        for lang, src, ver in (("python", p.py, versions["python"]), ("cpp", p.cpp, versions["cpp"])):
            report = (f"Executed on {n_tests} tests ({len(p.examples)} public examples + {len(p.hidden_inputs)} hidden) with {ver}. "
                      f"The stored expected outputs come from this program; the independent Python and C++ references produced identical "
                      f"token output on every test, and every example's stated output matched. Verified by catalog/build.py.{note}")
            w("INSERT INTO reference_solutions (problem_id, language, source_code, runtime_version, solution_version, verification_status, last_verified_at, validation_report)\n"
              f"SELECT p.id, {q(lang)}, {q(src.strip() + chr(10))}, {q(ver)}, 1, 'VERIFIED', UTC_TIMESTAMP(6), {q(report)} FROM problems p WHERE p.slug = {sl};")
        w("")
    return "\n".join(out) + "\n"
