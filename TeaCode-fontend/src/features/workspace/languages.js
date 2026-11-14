// Maps backend language keys to Monaco language ids. Which languages are offered at all is decided by the
// backend (credentials configured, not disabled by the operator); unknown keys fall back to plaintext.
const MONACO_ID = {
  java: 'java', python: 'python', c: 'c', cpp: 'cpp', javascript: 'javascript', typescript: 'typescript',
  csharp: 'csharp', php: 'php', ruby: 'ruby', go: 'go', r: 'r', kotlin: 'kotlin', rust: 'rust', swift: 'swift', dart: 'dart', sql: 'mysql',
};

export function monacoLanguage(key) {
  return MONACO_ID[key] ?? 'plaintext';
}

// Limits mirrored from the backend (which enforces them again).
export const MAX_SOURCE_CHARS = 64000;
export const MAX_STDIN_CHARS = 10000;

// Editable starting points for the standalone compiler. These are editor templates only; nothing is ever
// "executed" client-side. Each reads one line from standard input when there is one.
export const TERMINAL_TEMPLATES = {
  java: 'import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner in = new Scanner(System.in);\n        String name = in.hasNextLine() ? in.nextLine() : "TeaCode";\n        System.out.println("Hello, " + name + "!");\n    }\n}\n',
  python: 'import sys\n\nname = sys.stdin.readline().strip() or "TeaCode"\nprint(f"Hello, {name}!")\n',
  c: '#include <stdio.h>\n\nint main(void) {\n    char name[100] = "TeaCode";\n    if (scanf("%99s", name) != 1) { /* keep default */ }\n    printf("Hello, %s!\\n", name);\n    return 0;\n}\n',
  cpp: '#include <iostream>\n#include <string>\nusing namespace std;\n\nint main() {\n    string name = "TeaCode";\n    cin >> name;\n    cout << "Hello, " << name << "!" << endl;\n    return 0;\n}\n',
  javascript: 'const lines = require("fs").readFileSync(0, "utf8").split("\\n");\nconst name = lines[0] || "TeaCode";\nconsole.log(`Hello, ${name}!`);\n',
  typescript: 'import * as fs from "fs";\n\nconst lines: string[] = fs.readFileSync(0, "utf8").split("\\n");\nconst name: string = lines[0] || "TeaCode";\nconsole.log(`Hello, ${name}!`);\n',
  csharp: 'using System;\n\nclass Program {\n    static void Main() {\n        string name = Console.ReadLine() ?? "TeaCode";\n        Console.WriteLine($"Hello, {name}!");\n    }\n}\n',
  php: '<?php\n$name = trim(fgets(STDIN) ?: "TeaCode");\necho "Hello, $name!\\n";\n',
  ruby: 'name = (gets || "TeaCode").strip\nputs "Hello, #{name}!"\n',
  go: 'package main\n\nimport (\n\t"bufio"\n\t"fmt"\n\t"os"\n)\n\nfunc main() {\n\tname := "TeaCode"\n\tif s, err := bufio.NewReader(os.Stdin).ReadString(\'\\n\'); err == nil || len(s) > 0 {\n\t\tname = s\n\t}\n\tfmt.Printf("Hello, %s!\\n", name)\n}\n',
  r: 'input <- readLines(file("stdin"), n = 1)\nname <- if (length(input) > 0) input else "TeaCode"\ncat("Hello, ", name, "!\\n", sep = "")\n',
  kotlin: 'fun main() {\n    val name = readLine() ?: "TeaCode"\n    println("Hello, $name!")\n}\n',
  rust: 'use std::io::{self, BufRead};\n\nfn main() {\n    let mut name = String::from("TeaCode");\n    if let Some(Ok(line)) = io::stdin().lock().lines().next() {\n        name = line;\n    }\n    println!("Hello, {}!", name);\n}\n',
  swift: 'let name = readLine() ?? "TeaCode"\nprint("Hello, \\(name)!")\n',
  dart: "import 'dart:io';\n\nvoid main() {\n  final name = stdin.readLineSync() ?? 'TeaCode';\n  print('Hello, $name!');\n}\n",
  sql: 'SELECT CONCAT(\'Hello, \', \'TeaCode\', \'!\') AS greeting;\n',
};

export function templateFor(key) {
  return TERMINAL_TEMPLATES[key] ?? '';
}
