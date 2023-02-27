# Store the output in a variable
$output = "6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:91:4b:90 brd ff:ff:ff:ff:ff:ff
    inet 172.17.247.27/20 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fe91:4b90/64 scope link 
       valid_lft forever preferred_lft forever"

if ($output) {

  # Wait for the WSL instance to have an IP address
  while ($true) {
    $ipAddress = $output | select-string -pattern "inet "
    if ($ipAddress) {
      $ipAddress = $ipAddress -replace '\s+', ' ' -split ' ' | select -skip 1
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


############################################################################################################################

# Store the output in a variable
$output = "inet 172.17.247.27/20 brd 172.17.255.255 scope global eth0"

# Extract the IP address using regex
$ipRegex = [regex]::new("\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}")
$ipMatch = $ipRegex.Match($output)

if ($ipMatch.Success) {
    $ipAddress = $ipMatch.Value
    Write-Host $ipAddress
} else {
    Write-Host "No IP address found in the output."
}

