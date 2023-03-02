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

# Get all *-json.txt files in the current directory
$jsonFiles = Get-ChildItem -Path . -Filter "*-json.txt"

# Loop through each JSON file
foreach ($jsonFile in $jsonFiles) {
    # Define the input and output file paths
    $inputFilePath = $jsonFile.FullName
    $outputFilePath = Join-Path $outputDirPath ($jsonFile.BaseName + "-filtered.json")

    # Read the input file
    $fileContent = Get-Content -Path $inputFilePath -Raw | ConvertFrom-Json

    # Filter the "Running services" section
    $runningServices = $fileContent."Running services" | Where-Object {$_.DisplayName -notmatch "^@|^Microsoft|Service Control Manager|^Windows|Example 1|Example 2|Example 3"}
    $fileContent."Running services" = $runningServices

    # Filter the "Startup services" section
    $startupServices = $fileContent."Startup services" | Where-Object {$_.Name -notmatch "^Microsoft|Example A|Example B|Example C"}
    $fileContent."Startup services" = $startupServices

    # Filter the "Installed apps" section
    $installedApps = $fileContent."Installed apps" | Where-Object {$_.DisplayName -notmatch "^Update for|^Microsoft|Example 4|Example 5|Example 6"}
    $fileContent."Installed apps" = $installedApps

    # Write the filtered content to the output file
    $fileContent | ConvertTo-Json | Out-File -FilePath $outputFilePath
}
