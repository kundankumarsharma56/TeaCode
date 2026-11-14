# Runs a hello-world in each interactive runtime through the terminal runner and prints PASS/FAIL per language.
# Usage:  .\scripts\check-languages.ps1                (all 15)     .\scripts\check-languages.ps1 -Languages kotlin,java
param([string[]]$Languages = @(), [string]$Runner = 'teacode-terminal-runner-1')
$js = Get-Content -Raw (Join-Path $PSScriptRoot 'language-matrix.mjs')
$js | docker exec -i $Runner node --input-type=module - $Languages