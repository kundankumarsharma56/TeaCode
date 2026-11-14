# Builds the sandbox images that are not on Docker Hub and loads them into the sandbox daemon.
# Run again after changing terminal-runner\images\* or on a new machine / server.
param([string]$Sandbox = 'teacode-terminal-docker-1')
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$tar = Join-Path $env:TEMP 'teacode-kotlin.tar'
docker build -t teacode/kotlin:2.4.21 (Join-Path $root 'terminal-runner\images\kotlin')
if ($LASTEXITCODE -ne 0) { throw 'Kotlin image build failed' }
docker save -o $tar teacode/kotlin:2.4.21
docker cp $tar "${Sandbox}:/tmp/teacode-kotlin.tar"
docker exec $Sandbox sh -c 'DOCKER_HOST=unix:///run/user/1000/docker.sock docker load -i /tmp/teacode-kotlin.tar'
Remove-Item $tar