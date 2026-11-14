<#
.SYNOPSIS  Checks that the tools needed to build and test TeaCode are installed. Prints versions only, never secrets.
.EXAMPLE   .\scripts\dev-check.ps1
#>
$ErrorActionPreference = "Stop"
$failed = $false

function Test-Tool([string]$Name, [string]$VersionArgs, [string]$Needed, [bool]$Required = $true) {
    $cmd = Get-Command $Name -ErrorAction SilentlyContinue
    if (-not $cmd) {
        $label = if ($Required) { "MISSING" } else { "optional, missing" }
        Write-Host ("{0,-8} {1} ({2})" -f $label, $Name, $Needed)
        if ($Required) { $script:failed = $true }
        return
    }
    $version = (& $Name $VersionArgs.Split(" ") 2>&1 | Select-Object -First 1)
    Write-Host ("ok       {0}: {1}" -f $Name, $version)
}

Test-Tool "git"    "--version" "any"
Test-Tool "node"   "--version" "22 or newer"
Test-Tool "npm"    "--version" "10 or newer"
Test-Tool "java"   "-version"  "Java 21"
Test-Tool "mvn"    "-version"  "Maven 3.9+ (backend)"
Test-Tool "python" "--version" "3.12+ (catalog validator)" $false
Test-Tool "g++"    "--version" "needed by the catalog validator" $false
Test-Tool "docker" "--version" "Docker is needed for integration tests and the judge/terminal runner" $false

if ($failed) { Write-Host "dev-check: required tools are missing."; exit 1 }
Write-Host "dev-check: required tools are present."
exit 0
