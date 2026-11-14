# Start TeaCode locally on http://localhost:8081 (HTTP, dev profile). Run from this folder:
#   powershell -ExecutionPolicy Bypass -File start-local.ps1
# Keeps all volumes and data. For a real deployment use docker-compose.yml alone with an https:// APP_PUBLIC_URL.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
if (-not (Test-Path ".env")) { Write-Host "Missing .env. Copy .env.example to .env and fill in the secrets first." -ForegroundColor Red; exit 1 }
$compose = @("-f", "docker-compose.yml", "-f", "docker-compose.dev.yml", "--profile", "full")
docker compose @compose up -d --build backend frontend
if ($LASTEXITCODE -ne 0) { Write-Host "Build/start failed. See the output above." -ForegroundColor Red; exit 1 }
Write-Host "Waiting for the backend to become healthy (first start runs database migrations)..."
for ($i = 0; $i -lt 60; $i++) {
  $state = docker inspect --format "{{.State.Health.Status}}" (docker compose @compose ps -q backend) 2>$null
  if ($state -eq "healthy") { break }
  Start-Sleep -Seconds 5
}
docker compose @compose ps
Write-Host "`nOpen http://localhost:8081  (hard refresh with Ctrl+F5)" -ForegroundColor Green
Write-Host "Then run: powershell -ExecutionPolicy Bypass -File smoke-test.ps1"
Write-Host "If something fails: docker compose $($compose -join ' ') logs backend --tail 200"
