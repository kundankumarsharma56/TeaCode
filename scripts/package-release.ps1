<#
.SYNOPSIS  Builds a release ZIP of the repository without secrets, caches or build output, and writes its SHA-256.
.EXAMPLE   .\scripts\package-release.ps1
#>
param([string]$OutDir = "release")
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

if (Test-Path ".env") { Write-Host "Note: .env exists locally and is excluded from the ZIP." }

$excludeDirs = @("node_modules", "target", "dist", "__pycache__", ".git", $OutDir)
$excludeFiles = @(".env", "*.pem", "*.p12", "*.jks", "*.log", "*.pyc", "*serviceAccount*.json")

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$zip = Join-Path $OutDir "teacode-$stamp.zip"
$stage = Join-Path ([System.IO.Path]::GetTempPath()) "teacode-stage-$stamp"

$xd = $excludeDirs | ForEach-Object { @("/XD", (Join-Path $root $_)) } | ForEach-Object { $_ }
robocopy $root $stage /E /NFL /NDL /NJH /NJS /NP $xd /XF $excludeFiles | Out-Null
if ($LASTEXITCODE -ge 8) { throw "robocopy failed with exit code $LASTEXITCODE" }

Compress-Archive -Path (Join-Path $stage "*") -DestinationPath $zip -Force
Remove-Item -Recurse -Force $stage

$hash = (Get-FileHash -Algorithm SHA256 $zip).Hash.ToLower()
"$hash  $(Split-Path -Leaf $zip)" | Set-Content -Encoding ascii "$zip.sha256"
Write-Host "ZIP:    $zip"
Write-Host "SHA256: $hash"
exit 0
