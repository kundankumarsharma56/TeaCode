import WebSocket from 'ws';
const sources = {
  python: 'print("hi from python")',
  java: 'public class Main { public static void main(String[] a) { System.out.println("hi from java"); } }',
  c: '#include <stdio.h>\nint main(void){ printf("hi from c\\n"); return 0; }',
  cpp: '#include <iostream>\nint main(){ std::cout << "hi from cpp" << std::endl; }',
  javascript: 'console.log("hi from javascript");',
  typescript: 'const msg: string = "hi from typescript";\nconsole.log(msg);',
  csharp: 'Console.WriteLine("hi from csharp");',
  php: '<?php echo "hi from php" . PHP_EOL;',
  ruby: 'puts "hi from ruby"',
  go: 'package main\nimport "fmt"\nfunc main() { fmt.Println("hi from go") }',
  r: 'cat("hi from r\\n")',
  kotlin: 'fun main() { println("hi from kotlin") }',
  rust: 'fn main() { println!("hi from rust"); }',
  swift: 'print("hi from swift")',
  dart: 'void main() { print("hi from dart"); }'
};
const wanted = process.argv.slice(2).length ? process.argv.slice(2) : Object.keys(sources);
async function runOne(lang) {
  const r = await fetch('http://127.0.0.1:3000/sessions', { method: 'POST', headers: { 'x-internal-token': process.env.TERMINAL_RUNNER_INTERNAL_TOKEN, 'content-type': 'application/json' }, body: JSON.stringify({ language: lang }) });
  if (r.status !== 201) return { ok: false, note: 'create session -> ' + r.status, out: '' };
  const s = await r.json();
  return await new Promise((resolve) => {
    let out = ''; let done = false;
    const finish = (v) => { if (done) return; done = true; clearTimeout(timer); try { ws.close(); } catch { /* ignore */ } resolve(v); };
    const ws = new WebSocket('ws://127.0.0.1:3000/ws/' + s.sessionId);
    const timer = setTimeout(() => finish({ ok: false, note: 'TIMEOUT 240s', out }), 240000);
    ws.on('open', () => ws.send(JSON.stringify({ type: 'auth', token: s.token })));
    ws.on('message', (m) => {
      const x = JSON.parse(m.toString());
      if (x.type === 'authenticated') ws.send(JSON.stringify({ type: 'start', language: lang, sourceCode: sources[lang] }));
      if (x.type === 'output') out += x.data;
      if (x.type === 'exit') finish({ ok: x.state === 'finished' && out.includes('hi from ' + lang), note: `state=${x.state} exit=${x.exitCode ?? '-'} phase=${x.phase ?? '-'} ${x.message ?? ''}`, out });
    });
    ws.on('error', (e) => finish({ ok: false, note: 'ws error ' + e.message, out }));
    ws.on('close', () => finish({ ok: false, note: 'closed early', out }));
  });
}
let pass = 0; let fail = 0;
for (const lang of wanted) {
  if (!sources[lang]) { console.log(`SKIP  ${lang} (no test program)`); continue; }
  const t0 = Date.now();
  const r = await runOne(lang);
  if (r.ok) pass += 1; else fail += 1;
  console.log(`${r.ok ? 'PASS' : 'FAIL'}  ${lang.padEnd(11)} ${((Date.now() - t0) / 1000).toFixed(1).padStart(6)}s  ${r.note}`);
  if (!r.ok) console.log('      output: ' + JSON.stringify(r.out.slice(0, 500)));
}
console.log(`\n${pass} passed, ${fail} failed`);
process.exit(fail ? 1 : 0);