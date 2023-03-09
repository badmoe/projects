# Get the hostname of the machine
$hostname = $env:COMPUTERNAME

# Define the output file paths
$jsonFilePath = "C:\$($hostname)-report.json"
$infoFilePath = "C:\$($hostname)-report.txt"

# Add header for running services section in $infoFilePath
"`nRunning services:`n" | Out-File -FilePath $infoFilePath -Append
# Get running services
$runningServices = Get-Service | Where-Object {$_.Status -eq "Running"}
# Output running services as a string to $infoFilePath
$runningServices | Out-File -FilePath $infoFilePath -Append

# Add header for startup services section in $infoFilePath
"`nStartup services:`n" | Out-File -FilePath $infoFilePath -Append
# Get services that run at startup
$startupServices = Get-CimInstance -ClassName Win32_Service | Where-Object {$_.StartMode -eq "Auto"}
# Output startup services as a string to $infoFilePath
$startupServices | Out-File -FilePath $infoFilePath -Append

# Add header for non-service user login details section in $infoFilePath
"`nNon-service user login details:`n" | Out-File -FilePath $infoFilePath -Append
# Get all non-service user logon events for non-system users
$logins = Get-WinEvent -FilterHashtable @{LogName="Security";ID="4624"} | ForEach-Object {
    $wevent = $_
    $user = $wevent.Properties[5].Value
    $time = $wevent.TimeCreated
    $ip = $wevent.Properties[18].Value
    $type = $wevent.Properties[8].Value
    if ($type -eq 10 -and $user -notmatch "NT AUTHORITY\SYSTEM") {
        [PSCustomObject]@{
            User = $user
            Time = $time
            IP = $ip
            Type = $type
        }
    }
} | Select-Object -Last 5
# Output non-service user login details as a string to $infoFilePath
$logins | Out-File -FilePath $infoFilePath -Append

# Add header for installed apps section in $infoFilePath
"`nInstalled apps:`n" | Out-File -FilePath $infoFilePath -Append
# Get installed apps
$apps = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | 
    Select-Object DisplayName, DisplayVersion | 
    Where-Object { $_.DisplayName -ne $null -and $_.DisplayVersion -ne $null }
# Output installed apps as a string to $infoFilePath
$apps | Out-File -FilePath $infoFilePath -Append

@{
    "logins" = $logins
    "apps" = $apps
    "services" = @{
        "running" = $runningServices
        "startup" = $startupServices
    }
} | ConvertTo-Json | Out-File -FilePath $jsonFilePath
