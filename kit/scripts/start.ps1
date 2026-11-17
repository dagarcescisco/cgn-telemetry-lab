param([string]$Session = "")
# Starts the portable PuTTY with the preconfigured sessions of the CGN & Telemetry training lab.
#   no parameter  -> opens PuTTY with the list of saved sessions
#   -Session NAME -> opens that session directly: COLLECTOR | CORE | PE-ACC | PE-A | PE-B | CGN-A1 | CGN-B1 | SUB | INET-SRV
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

# 4. Desktop shortcuts, so that the kit is easy to find (re-created on every run).
try {
    $desk = [Environment]::GetFolderPath("Desktop")
    $sh = New-Object -ComObject WScript.Shell
    $l = $sh.CreateShortcut((Join-Path $desk "CGN Lab - PuTTY.lnk"))
    $l.TargetPath = Join-Path $kit "Start-PuTTY.cmd"; $l.WorkingDirectory = $kit
    $l.IconLocation = "$exe,0"; $l.WindowStyle = 7; $l.Description = "PuTTY sessions of the CGN & Telemetry training lab"; $l.Save()
    $g = $sh.CreateShortcut((Join-Path $desk "CGN Lab - Guides.lnk"))
    $g.TargetPath = Join-Path $kit "guides"; $g.Description = "CGN & Telemetry training guides (PDF)"; $g.Save()
    # one shortcut per device (and the COLLECTOR) in a Desktop folder
    $dev = Join-Path $desk "CGN Lab - Devices"
    New-Item -ItemType Directory -Path $dev -Force | Out-Null
    Get-ChildItem -Path (Join-Path $kit "connect") -Filter *.cmd | ForEach-Object {
        $d = $sh.CreateShortcut((Join-Path $dev ($_.BaseName + ".lnk")))
        $d.TargetPath = $_.FullName; $d.WorkingDirectory = $kit; $d.IconLocation = "$exe,0"; $d.WindowStyle = 7
        $d.Description = "PuTTY session: " + $_.BaseName; $d.Save()
    }
} catch { }

# 5. Open the session. The first connection asks to accept the SSH host key: answer Accept.
if ($Session) { Start-Process -FilePath $exe -ArgumentList @("-load", $Session, "-pw", "cisco") }
else { Start-Process -FilePath $exe }
