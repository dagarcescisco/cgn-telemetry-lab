param([string]$Session = "COLLECTOR")
# Starts the portable PuTTY with the preconfigured sessions of the CGN & Telemetry training lab.
#   -Session COLLECTOR | CORE | PE-ACC | PE-A | PE-B | CGN-A1 | CGN-B1 | SUB | INET-SRV
$ErrorActionPreference = "Continue"
$kit   = Split-Path -Parent $PSScriptRoot
$putty = Join-Path $kit "putty"
$exe   = Join-Path $putty "putty.exe"
if (-not (Test-Path $exe)) { Write-Host "putty.exe not found in $putty" -ForegroundColor Red; Read-Host "Press Enter"; exit 1 }

# Files downloaded from the Internet are blocked by Windows: clear the mark so that PuTTY starts without a prompt.
Get-ChildItem -Path $kit -Recurse -File | Unblock-File -ErrorAction SilentlyContinue

# 1. Load the sessions into the registry of the current user (no administrator rights needed).
$src = Get-Content (Join-Path $putty "sessions.reg") -Raw
$tmp = Join-Path $env:TEMP "cgn-putty-sessions.reg"
Set-Content -Path $tmp -Value $src -Encoding Unicode
$imp = reg import $tmp 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Could not load the PuTTY sessions: $imp" -ForegroundColor Red
    Read-Host "Press Enter to continue anyway"
}

# 2. The lab devices are rebuilt between days and get new SSH host keys: forget the old ones so that PuTTY
#    does not raise a "host key changed" alarm.
$hk = "HKCU:\Software\SimonTatham\PuTTY\SshHostKeys"
if (Test-Path $hk) {
    (Get-Item $hk).Property | Where-Object { $_ -match '@22:(198\.18\.128\.3|10\.250\.0\.\d+)$' } |
        ForEach-Object { Remove-ItemProperty -Path $hk -Name $_ -ErrorAction SilentlyContinue }
}

# 3. Warn early if the VPN or the lab is not there.
try {
    $c = New-Object System.Net.Sockets.TcpClient
    $ok = $c.ConnectAsync("198.18.128.3", 22).Wait(3000)
    $c.Close()
} catch { $ok = $false }
if (-not $ok) {
    Write-Host "The COLLECTOR (198.18.128.3:22) does not answer. Check that the VPN is connected and that the lab of the day is started and booted." -ForegroundColor Yellow
}

# 4. Open the session. The first connection asks to accept the SSH host key: answer Accept.
Start-Process -FilePath $exe -ArgumentList @("-load", $Session, "-pw", "cisco")
