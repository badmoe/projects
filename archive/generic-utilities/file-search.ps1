# Check if ran as administrator
$adminCheck=[bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
if (!$adminCheck) {
    "Please run as administrator. Exiting..."
    sleep 5
    exit 1
}

# Collect!
$search = Read-Host "Search drive for"
$drive = Read-Host "Search drive letter or location path"

# Append!
$measureDrive = $drive | Measure-Object -Character
if ($measureDrive.Characters -eq 1) {
    $drive = $drive+":\"
}

# Locate!
Write-Host -fore Green "Searching ${drive} for anything that contains ${search}"
Get-ChildItem -Recurse -File -Include *${search}* -Path ${drive}
