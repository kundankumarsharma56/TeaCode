# TeaCode smoke test. Run from any folder:  powershell -ExecutionPolicy Bypass -File smoke-test.ps1
# Uses a throwaway account. Prints PASS/FAIL per check and never prints passwords or tokens.
$base = "http://localhost:8081"
$ws = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$pass = 0; $fail = 0
function Check($name, $ok, $detail) {
  if ($ok) { Write-Host "PASS  $name"; $script:pass++ } else { Write-Host "FAIL  $name  -> $detail"; $script:fail++ }
}
function Call($method, $path, $body) {
  $h = @{ Origin = $base }
  $c = $ws.Cookies.GetCookies([Uri]$base) | Where-Object { $_.Name -eq 'XSRF-TOKEN' }
  if ($c) { $h['X-XSRF-TOKEN'] = $c.Value }
  try {
    $p = @{ Uri = "$base/api/v1$path"; Method = $method; WebSession = $ws; Headers = $h; UseBasicParsing = $true }
    if ($body) { $p.Body = ($body | ConvertTo-Json); $p.ContentType = 'application/json' }
    $r = Invoke-WebRequest @p
    return @{ Status = [int]$r.StatusCode; Body = $r.Content }
  } catch {
    $resp = $_.Exception.Response
    $text = ''
    if ($resp) { try { $text = (New-Object IO.StreamReader($resp.GetResponseStream())).ReadToEnd() } catch {} }
    return @{ Status = $(if ($resp) { [int]$resp.StatusCode } else { 0 }); Body = $text }
  }
}

# 1. Problems: only TeaCode-owned
$r = Call GET "/problems?size=50"
$j = $r.Body | ConvertFrom-Json
Check "Problem list loads" ($r.Status -eq 200 -and $j.totalItems -gt 0) "status $($r.Status)"
Check "No CODEFORCES problems on page 1" (-not ($j.items | Where-Object { $_.source -eq 'CODEFORCES' })) "found Codeforces items"
$r = Call GET "/problems?source=CODEFORCES"
Check "source=CODEFORCES is rejected (400)" ($r.Status -eq 400) "status $($r.Status)"
$slug = $j.items[0].slug
$r = Call GET "/problems/$slug"
Check "Problem detail loads ($slug)" ($r.Status -eq 200) "status $($r.Status)"

# 2. Signup / login
$u = "smoke" + (Get-Random -Maximum 99999999)
$email = "$u@example.com"
$pw = "Smoke-" + [guid]::NewGuid().ToString("N").Substring(0,16)
$reg = @{ username = $u; email = $email; password = $pw; acceptPolicies = $true; policyVersion = "2026-10-14-draft" }
$r = Call POST "/auth/register" $reg
Check "Signup valid -> 202" ($r.Status -eq 202) "status $($r.Status) $($r.Body)"
$r = Call POST "/auth/register" @{ username = "x"; email = "bad"; password = "short"; acceptPolicies = $false; policyVersion = "v" }
Check "Signup invalid -> 400" ($r.Status -eq 400) "status $($r.Status)"
$dup = $reg.Clone(); $dup.username = $u + "b"
$r = Call POST "/auth/register" $dup
Check "Signup existing email -> 202 (no enumeration)" ($r.Status -eq 202) "status $($r.Status)"
$r = Call POST "/auth/login" @{ email = $email; password = "wrong-password-123" }
Check "Login wrong password -> 401" ($r.Status -eq 401) "status $($r.Status)"
$r = Call POST "/auth/login" @{ email = $email; password = $pw }
Check "Login valid -> 200" ($r.Status -eq 200) "status $($r.Status) $($r.Body)"
$r = Call GET "/auth/me"
Check "Authenticated /auth/me -> 200" ($r.Status -eq 200) "status $($r.Status)"

# 3. Terminal (this was the 403)
$r = Call GET "/execution/languages"
Check "Languages available" ($r.Status -eq 200 -and ($r.Body | ConvertFrom-Json).Count -gt 0) "status $($r.Status) body $($r.Body)"
$r = Call POST "/terminal/sessions" @{ language = "python" }
Check "Terminal session created (200, was 403)" ($r.Status -eq 200 -and ($r.Body | ConvertFrom-Json).sessionId) "status $($r.Status) $($r.Body)"

# 4. Logout
$r = Call POST "/auth/logout"
Check "Logout -> 204" ($r.Status -eq 204) "status $($r.Status)"
$r = Call GET "/auth/me"
Check "After logout /auth/me -> 401" ($r.Status -eq 401) "status $($r.Status)"

Write-Host "`n$pass passed, $fail failed"
