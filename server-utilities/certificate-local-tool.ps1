# Function to compare certificate templates
Function Compare-CertificateTemplates {
    # Get all certificate templates on the local server
    $certTemplates = Get-ChildItem -Path "Cert:\LocalMachine\CertificateTemplates"

    # Initialize an array to store the certificate template details
    $templateDetails = @()

    # Get the subject, subject alternative name, and key usage for each certificate template
    Foreach ($template in $certTemplates) {
        $subject = $template.SubjectName
        $san = $template.SubjectAltName
        $ku = $template.KeyUsage

        # Add the certificate template details to the array
        $templateDetails += [PSCustomObject]@{
            Subject = $subject
            SAN = $san
            KU = $ku
        }
    }

    # Compare each certificate template to all others
    For ($i = 0; $i -lt $templateDetails.Count; $i++) {
        For ($j = $i + 1; $j -lt $templateDetails.Count; $j++) {
            Write-Host "Comparing certificate template $($i + 1) to certificate template $($j + 1):"
            If ($templateDetails[$i].Subject -ne $templateDetails[$j].Subject) { Write-Host "Subject differs: $($templateDetails[$i].Subject) vs $($templateDetails[$j].Subject)" }
            If ($templateDetails[$i].SAN -ne $templateDetails[$j].SAN) { Write-Host "Subject Alternative Name differs: $($templateDetails[$i].SAN) vs $($templateDetails[$j].SAN)" }
            If ($templateDetails[$i].KU -ne $templateDetails[$j].KU) { Write-Host "Key Usage differs: $($templateDetails[$i].KU) vs $($templateDetails[$j].KU)" }
            Write-Host ""
        }
    }
}

While ($true) {
    Write-Host "Please select a function to run:"
    Write-Host "1. Compare Certificate Templates"
    Write-Host "2. Quit Script"
    $function = Read-Host "Enter the number of the function you would like to run: "
    
    Switch ($function) {
        1 { Compare-CertificateTemplates }
        2 { Break }
        Default { Write-Host "Invalid selection. Please try again." }
    }
    
    If ($function -eq 2) {
        Break
    }
}