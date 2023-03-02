# Define the output directory path
$outputDirPath = ".\Outputs"

# Define the filter values
$runningServicesFilter = @("Example 1", "Example 2", "Example 3")
$startupServicesFilter = @("Example A", "Example B", "Example C")
$installedAppsFilter = @("Example 4", "Example 5", "Example 6")

# Check if the output directory exists and create it if it doesn't
if (-not (Test-Path $outputDirPath)) {
    New-Item -ItemType Directory -Path $outputDirPath | Out-Null
}

# Get all *-info.txt files in the current directory
$infoFiles = Get-ChildItem -Path . -Filter "*-info.txt"

# Loop through each info file
foreach ($infoFile in $infoFiles) {
    # Define the input and output file paths
    $inputFilePath = $infoFile.FullName
    $outputFilePath = Join-Path $outputDirPath ($infoFile.BaseName + "-filtered.txt")

    # Read the input file
    $fileContent = Get-Content -Path $inputFilePath

    # Filter the "Running services" section
    $runningServicesSectionStart = $fileContent.IndexOf("`nRunning services:`n") + 1
    if ($runningServicesSectionStart -ne 0) {
        $runningServicesSectionEnd = $fileContent.IndexOf("`n", $runningServicesSectionStart + 1)
        $runningServicesSection = $fileContent.Substring($runningServicesSectionStart, $runningServicesSectionEnd - $runningServicesSectionStart)
        $runningServices = $runningServicesSection -split "`r`n" | Where-Object {($_ -notmatch "DisplayName.*Example [123]") -and ($_ -ne "")}
        $fileContent = $fileContent.Replace($runningServicesSection, "`n$runningServices`n")
    }

    # Filter the "Startup services" section
    $startupServicesSectionStart = $fileContent.IndexOf("`nStartup services:`n") + 1
    if ($startupServicesSectionStart -ne 0) {
        $startupServicesSectionEnd = $fileContent.IndexOf("`n", $startupServicesSectionStart + 1)
        $startupServicesSection = $fileContent.Substring($startupServicesSectionStart, $startupServicesSectionEnd - $startupServicesSectionStart)
        $startupServices = $startupServicesSection -split "`r`n" | Where-Object {($_ -notmatch "Name.*Example [ABC]") -and ($_ -ne "")}
        $fileContent = $fileContent.Replace($startupServicesSection, "`n$startupServices`n")
    }

    # Filter the "Installed apps" section
    $installedAppsSectionStart = $fileContent.IndexOf("`nInstalled apps:`n") + 1
    if ($installedAppsSectionStart -ne 0) {
        $installedAppsSectionEnd = $fileContent.IndexOf("`n", $installedAppsSectionStart + 1)
        $installedAppsSection = $fileContent.Substring($installedAppsSectionStart, $installedAppsSectionEnd - $installedAppsSectionStart)
        $installedApps = $installedAppsSection -split "`r`n" | Where-Object {($_ -notmatch "DisplayName.*Example [456]") -and ($_ -ne "")}
        $fileContent = $fileContent.Replace($installedAppsSection, "`n$installedApps`n")
    }

    # Write the filtered content to the output file
    $fileContent | Out-File -FilePath $outputFilePath
}
