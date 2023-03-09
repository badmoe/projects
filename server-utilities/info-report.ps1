# Get the hostname of the machine
$hostname = $env:COMPUTERNAME

# Define the output file paths
$jsonFilePath = "C:\$($hostname).json"
$infoFilePath = "C:\$($hostname)-report.txt"

# Add header for non-service user login details section in $infoFilePath
"`nNon-service user login details:`n" | Out-File -FilePath $infoFilePath
# Get all non-service user logon events for non-system users
$logins = Get-WinEvent -ProviderName 'Microsoft-Windows-Security-Auditing' -FilterXPath "*[System[EventID=4624] and EventData[Data[@Name='LogonType']='7']]" -MaxEvents 10 |
Select-Object TimeCreated, @{Name="User";Expression={$_.Properties[5].Value}}
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

# Output all sections as JSON to $jsonFilePath
@{
    "logins" = $logins
    "apps" = $apps
    "services" = @{
        "running" = $runningServices
        "startup" = $startupServices
    }
} | ConvertTo-Json | Out-File -FilePath $jsonFilePath
