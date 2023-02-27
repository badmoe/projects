# Get the hostname of the machine
$hostname = $env:COMPUTERNAME

# Define the output file paths
$jsonFilePath = "C:\$($hostname)-json.txt"
$infoFilePath = "C:\$($hostname)-info.txt"

# Get running services
$runningServices = Get-Service | Where-Object {$_.Status -eq "Running"}

# Add header for running services section in $infoFilePath
"`nRunning services:`n" | Out-File -FilePath $infoFilePath -Append
# Output running services as JSON to $jsonFilePath
$runningServices | ConvertTo-Json | Out-File -FilePath $jsonFilePath
# Output running services as a string to $infoFilePath
$runningServices | Out-File -FilePath $infoFilePath -Append

# Get services that run at startup
$startupServices = Get-CimInstance -ClassName Win32_Service | Where-Object {$_.StartMode -eq "Auto"}

# Add header for startup services section in $infoFilePath
"`nStartup services:`n" | Out-File -FilePath $infoFilePath -Append
# Output startup services as JSON to $jsonFilePath
$startupServices | ConvertTo-Json | Out-File -FilePath $jsonFilePath -Append
# Output startup services as a string to $infoFilePath
$startupServices | Out-File -FilePath $infoFilePath -Append

# Get all non-service user logon events for non-system users
$logins = Get-WinEvent -FilterHashtable @{LogName="Security";ID="4624"} | ForEach-Object {
    $event = $_
    $user = $event.Properties[5].Value
    $time = $event.TimeCreated
    $ip = $event.Properties[18].Value
    $type = $event.Properties[8].Value
    if ($type -eq 10 -and $user -notmatch "NT AUTHORITY\SYSTEM") {
        [PSCustomObject]@{
            User = $user
            Time = $time
            IP = $ip
            Type = $type
        }
    }
} | Select-Object -Last 5

# Add header for non-service user login details section in $infoFilePath
"`nNon-service user login details:`n" | Out-File -FilePath $infoFilePath -Append
# Output non-service user login details as JSON to $jsonFilePath
$logins | ConvertTo-Json | Out-File -FilePath $jsonFilePath -Append
# Output non-service user login details as a string to $infoFilePath
$logins | Out-File -FilePath $infoFilePath -Append

# Get installed apps
$apps = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion

# Add header for installed apps section in $infoFilePath
"`nInstalled apps:`n" | Out-File -FilePath $infoFilePath -Append
# Output installed apps as JSON to $jsonFilePath
$apps | ConvertTo-Json | Out-File -FilePath $jsonFilePath -Append
# Output installed apps as a string to $infoFilePath
$apps | Out-File -FilePath $infoFilePath -Append
