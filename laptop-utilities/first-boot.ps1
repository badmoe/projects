<#
Windows 11 fresh-setup script
- Solid black desktop background
- Solid black lock screen background
- Taskbar aligned left
- Hide taskbar Search, Widgets, Task View
- Install Chocolatey

Run:  Right-click PowerShell -> "Run as administrator", then execute this script.
#>

# -------------------- Elevation --------------------
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
  Write-Host "Re-launching as Administrator..."
  Start-Process -FilePath "powershell.exe" -Verb RunAs -ArgumentList @(
    "-NoProfile","-ExecutionPolicy","Bypass","-File","`"$PSCommandPath`""
  )
  exit
}

$ErrorActionPreference = "Stop"

# -------------------- Create a 1x1 black PNG (no external deps) --------------------
$customDir = Join-Path $env:ProgramData "CustomSetup"
New-Item -Path $customDir -ItemType Directory -Force | Out-Null

$blackPngPath = Join-Path $customDir "black.png"

# 1x1 black PNG (valid) as base64
$blackPngBase64 = @"
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=
"@.Trim()

[IO.File]::WriteAllBytes($blackPngPath, [Convert]::FromBase64String($blackPngBase64))

# -------------------- Desktop background = solid black --------------------
# Set background color
New-Item -Path "HKCU:\Control Panel\Colors" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "Background" -Value "0 0 0"

# Set wallpaper to a black image and tell Windows to apply it
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport("user32.dll", SetLastError=true)]
  public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Wallpaper registry keys (still used for style + path)
New-Item -Path "HKCU:\Control Panel\Desktop" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Wallpaper"      -Value $blackPngPath
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallpaperStyle" -Value "10"   # Fill
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "TileWallpaper"  -Value "0"

# Apply wallpaper (SPI_SETDESKWALLPAPER = 20, SPIF_UPDATEINIFILE=1, SPIF_SENDCHANGE=2 => 3)
[void][Wallpaper]::SystemParametersInfo(20, 0, $blackPngPath, 3)

# -------------------- Lock screen background = solid black --------------------
Write-Host "Setting lock screen background (best-effort)..."

$lockErrors = $false

try {
    $polPersonalization = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
    New-Item -Path $polPersonalization -Force | Out-Null
    Set-ItemProperty -Path $polPersonalization -Name "LockScreenImage" -Type String -Value $blackPngPath
}
catch {
    Write-Warning "Lock screen policy key blocked by OS."
    $lockErrors = $true
}

try {
    $csp = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
    New-Item -Path $csp -Force | Out-Null
    Set-ItemProperty -Path $csp -Name "LockScreenImagePath" -Type String -Value $blackPngPath
    Set-ItemProperty -Path $csp -Name "LockScreenImageStatus" -Type DWord -Value 1
    Set-ItemProperty -Path $csp -Name "LockScreenImageUrl" -Type String -Value $blackPngPath
}
catch {
    Write-Warning "Lock screen CSP blocked by OS."
    $lockErrors = $true
}

if ($lockErrors) {
    Write-Host "Lock screen image could not be enforced (expected on Windows 11 Home)."
    Write-Host "Desktop background WAS applied successfully."
}

# -------------------- Taskbar settings --------------------
$adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
New-Item -Path $adv -Force | Out-Null

# Align left (0 = left, 1 = center)
Set-ItemProperty -Path $adv -Name "TaskbarAl" -Type DWord -Value 0

# Hide Search (0 = hidden)
Set-ItemProperty -Path $adv -Name "SearchboxTaskbarMode" -Type DWord -Value 0

# Hide Widgets (0 = off)
Set-ItemProperty -Path $adv -Name "TaskbarDa" -Type DWord -Value 0

# Hide Task View (0 = off)
Set-ItemProperty -Path $adv -Name "ShowTaskViewButton" -Type DWord -Value 0

# Restart Explorer to apply taskbar changes
Write-Host "Restarting Explorer..."
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Process explorer.exe

# -------------------- Install Chocolatey --------------------
Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072 # TLS 1.2
$chocoInstall = 'Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString("https://community.chocolatey.org/install.ps1"))'
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command $chocoInstall

Write-Host "`nDone."
Write-Host "Note: Lock screen image enforcement may require Windows 11 Pro/Enterprise; Windows Home may ignore it."
