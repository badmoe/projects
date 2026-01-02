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
# This uses policy keys (works best on Pro/Enterprise; on Home it may be ignored by the OS).
$polPersonalization = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
New-Item -Path $polPersonalization -Force | Out-Null
Set-ItemProperty -Path $polPersonalization -Name "LockScreenImage" -Type String -Value $blackPngPath

# Also set Personalization CSP values (sometimes honored where policy is not)
$csp = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
New-Item -Path $csp -Force | Out-Null
Set-ItemProperty -Path $csp -Name "LockScreenImagePath" -Type String -Value $blackPngPath
Set-It
