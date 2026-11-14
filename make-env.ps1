# Creates a LOCAL .env with fresh random secrets. Run from this folder:
#   powershell -ExecutionPolicy Bypass -File make-env.ps1
# It never overwrites an existing .env, and it never prints the secrets it generates.
# For a real deployment, edit APP_PUBLIC_URL (https://...) and SPRING_PROFILES_ACTIVE=prod yourself.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
if (Test-Path ".env") { Write-Host ".env already exists - leaving it alone." -ForegroundColor Yellow; exit 0 }
if (-not (Test-Path ".env.example")) { Write-Host ".env.example is missing." -ForegroundColor Red; exit 1 }

function New-Secret([int]$bytes) {
  $buffer = New-Object byte[] $bytes
  $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
  $rng.GetBytes($buffer)
  $rng.Dispose()
  return (($buffer | ForEach-Object { $_.ToString("x2") }) -join "")
}

$values = @{
  MYSQL_DATABASE                 = "codevibs"
  MYSQL_USER                     = "codevibs"
  MYSQL_PASSWORD                 = (New-Secret 24)
  MYSQL_ROOT_PASSWORD            = (New-Secret 24)
  SPRING_PROFILES_ACTIVE         = "dev"
  APP_PUBLIC_URL                 = "http://localhost:8081"
  JWT_SECRET                     = (New-Secret 32)
  TERMINAL_RUNNER_INTERNAL_TOKEN = (New-Secret 32)
}

$lines = Get-Content ".env.example" | ForEach-Object {
  if ($_ -match '^\s*([A-Z0-9_]+)=') {
    $key = $Matches[1]
    if ($values.ContainsKey($key)) { return "$key=$($values[$key])" }
  }
  return $_
}
Set-Content -Path ".env" -Value $lines -Encoding ascii
Write-Host "Created .env with new random secrets (local/dev settings: http://localhost:8081)." -ForegroundColor Green
Write-Host "Still empty on purpose: JDOODLE_CLIENT_ID / JDOODLE_CLIENT_SECRET (needed for judged runs and SQL) and the VITE_FIREBASE_* values (needed for sign-in)."
Write-Host "Next: powershell -ExecutionPolicy Bypass -File start-local.ps1"
