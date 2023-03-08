# Define the search pattern for files to include in the zip archive
$searchPattern = "PowerShell_transcript.*"

# Define the path to the Documents folder
$documentsPath = [Environment]::GetFolderPath("MyDocuments")

# Define the path to the Transcripts folder
$transcriptsPath = Join-Path $documentsPath "Transcripts"

# Find all folders in the Documents folder that contain files matching the search pattern
$foldersToZip = Get-ChildItem $documentsPath -Directory | Where-Object { (Get-ChildItem $_.FullName -File -Filter $searchPattern).Count -gt 0 }

# For each folder to zip, create a zip file in the Transcripts folder with the same name and delete the original folder
foreach ($folder in $foldersToZip) {
    $zipFileName = Join-Path $transcriptsPath ($folder.Name + ".zip")
    Compress-Archive -Path $folder.FullName -DestinationPath $zipFileName
    Remove-Item $folder.FullName -Recurse
}
