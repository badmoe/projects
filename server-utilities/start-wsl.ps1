# Set the name of the WSL instance
$wslInstanceName = "Ubuntu-20.04"

# Check if the WSL instance is running
$wslIsRunning = wsl.exe -d $wslInstanceName -u root -- ip a show eth0 up 2>$null

if (-not $wslIsRunning) {
  Write-Host "WSL instance is not running. Starting..."
  wsl.exe -d $wslInstanceName

  # Wait for the WSL instance to have an IP address
  while ($true) {
    $ipAddressRaw = wsl.exe -d $wslInstanceName -u root -- ip -4 addr show eth0 | select-string -pattern "inet "
    if ($ipAddressRaw) {
        $ipRegex = [regex]::new("\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}")
        $ipMatch = $ipRegex.Match($ipAddressRaw)

        if ($ipMatch.Success) {
            $ipAddress = $ipMatch.Value
            Write-Host $ipAddress
        } else {
            Write-Host "No IP address found in the output."
        }
      Write-Host "WSL instance has an IP address: $ipAddress"
      break
    }

    Write-Host "Waiting for WSL instance to have an IP address..."
    # Wait 5 seconds before checking again
    Start-Sleep -Seconds 5
  }
} else {
  Write-Host "WSL instance is running."

  # If the WSL instance is already running, check if it has an IP address
  while ($true) {
    $ipAddress = wsl.exe -d $wslInstanceName -u root -- ip -4 addr show eth0 | select-string -pattern "inet "
    if ($ipAddress) {
      $ipAddress = $ipAddress -replace '\s+', ' ' -split ' ' | select -skip 1
      Write-Host "WSL instance has an IP address: $ipAddress"
      break
    }

    Write-Host "Waiting for WSL instance to have an IP address..."
    # Wait 5 seconds before checking again
    Start-Sleep -Seconds 5
  }
}
