# Get running services
$runningServices = Get-Service | Where-Object {$_.Status -eq "Running"}

# Add header for running services section
"Running services:`n" | Out-File -FilePath "C:\text.txt"
# Output running services to file
$runningServices | Out-File -FilePath "C:\text.txt" -Append

# Get services that run at startup
$startupServices = Get-CimInstance -ClassName Win32_Service | Where-Object {$_.StartMode -eq "Auto"}

# Add header for startup services section
"`nStartup services:`n" | Out-File -FilePath "C:\text.txt" -Append
# Output startup services to file
$startupServices | Out-File -FilePath "C:\text.txt" -Append

# Get last 5 user logins and their details
$logins = Get-WinEvent -FilterHashtable @{LogName="Security";ID="4624"} -MaxEvents 5 | ForEach-Object {
    $event = $_
    $user = $event.Properties[5].Value
    $time = $event.TimeCreated
    $ip = $event.Properties[18].Value
    $type = $event.Properties[8].Value
    [PSCustomObject]@{
        User = $user
        Time = $time
        IP = $ip
        Type = $type
    }
}

# Add header for user login details section
"`nUser login details:`n" | Out-File -FilePath "C:\text.txt" -Append
# Output user login details to file
$logins | Out-File -FilePath "C:\text.txt" -Append

# Get installed apps
$apps = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion

# Add header for installed apps section
"`nInstalled apps:`n" | Out-File -FilePath "C:\text.txt" -Append
# Output installed apps to file
$apps | Out-File -FilePath "C:\text.txt" -Append

# Get documents folder contents for last 5 users
$documentsFolders = $logins | ForEach-Object {
    $user = $_.User
    $path = "C:\Users\$user\Documents"
    if (Test-Path $path) {
        Get-ChildItem $path -Recurse
    }
}

# Add header for documents folder contents section
"`nDocuments folder contents for last 5 users:`n" | Out-File -FilePath "C:\text.txt" -Append
# Output documents folder contents to file
$documentsFolders | Out-File -FilePath "C:\text.txt" -Append
