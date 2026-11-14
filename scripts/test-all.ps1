<#
.SYNOPSIS  Runs lint, tests and build for each part of TeaCode and reports PASS/FAIL per step.
.EXAMPLE   .\scripts\test-all.ps1
.EXAMPLE   .\scripts\test-all.ps1 -FrontendOnly
.EXAMPLE   .\scripts\test-all.ps1 -BackendOnly      # needs Docker (Testcontainers) for the integration tests
.EXAMPLE   .\scripts\test-all.ps1 -RunnerOnly
.EXAMPLE   .\scripts\test-all.ps1 -CatalogOnly      # runs every reference solution, takes about 2 minutes
#>
param(
    [switch]$FrontendOnly,
    [switch]$BackendOnly,
    [switch]$RunnerOnly,
    [switch]$CatalogOnly
)
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$results = @()

function Invoke-Step([string]$Name, [string]$Dir, [scriptblock]$Action) {
    Write-Host "`n=== $Name ===" -ForegroundColor Cyan
    Push-Location (Join-Path $root $Dir)
    try {
        & $Action
        if ($LASTEXITCODE -ne 0) { throw "exit code $LASTEXITCODE" }
        $script:results += [pscustomobject]@{ Step = $Name; Result = "PASS" }
    } catch {
        Write-Host "FAILED: $_" -ForegroundColor Red
        $script:results += [pscustomobject]@{ Step = $Name; Result = "FAIL" }
    } finally { Pop-Location }
}

$all = -not ($FrontendOnly -or $BackendOnly -or $RunnerOnly -or $CatalogOnly)

if ($all -or $FrontendOnly) {
    Invoke-Step "frontend: npm ci"    "TeaCode-fontend" { npm ci }
    Invoke-Step "frontend: lint"      "TeaCode-fontend" { npm run lint }
    Invoke-Step "frontend: tests"     "TeaCode-fontend" { npm test }
    Invoke-Step "frontend: build"     "TeaCode-fontend" { npm run build }
}
if ($all -or $RunnerOnly) {
    Invoke-Step "runner: npm ci"      "terminal-runner" { npm ci }
    Invoke-Step "runner: tests"       "terminal-runner" { npm test }
}
if ($all -or $BackendOnly) {
    Invoke-Step "backend: mvn verify" "backend" { mvn -B verify }
}
if ($all -or $CatalogOnly) {
    Invoke-Step "catalog: validate"   "." { python catalog/build.py --check }
}

Write-Host "`n=== Summary ===" -ForegroundColor Cyan
$results | Format-Table -AutoSize
if ($results.Result -contains "FAIL") { exit 1 }
exit 0
