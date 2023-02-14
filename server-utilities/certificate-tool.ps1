Function Export-PersonalCertificates {
    If (!(Test-Path "C:\certs\")) {
        New-Item -ItemType Directory -Path "C:\certs\"
    }
    
    Write-Host "Please select a certificate store to export certificates from:"
    Write-Host "1. CurrentUser\My"
    Write-Host "2. LocalMachine\My"
    $certStore = Read-Host "Enter the number of the certificate store you would like to export certificates from: "
    
    $certStorePath = "Cert:\"
    Switch ($certStore) {
        1 { $certStorePath += "CurrentUser\My" }
        2 { $certStorePath += "LocalMachine\My" }
        Default { Write-Host "Invalid selection. Please try again."; Return }
    }
    
    $certs = Get-ChildItem -Path $certStorePath | Where-Object { $_.HasPrivateKey }
    
    Foreach ($cert in $certs) {
        $filename = $cert.SerialNumber.Substring($cert.SerialNumber.Length - 4) + ".cer"
        $cert | Export-Certificate -Type CERT -FilePath "C:\certs\$filename"
    }
}

Function Check-CertificateLastUse {
    $certs = Get-ChildItem -Path "C:\certs\"
    
    Foreach ($cert in $certs) {
        $certData = Get-PfxCertificate -FilePath $cert.FullName
        $now = Get-Date
        $daysSinceLastUse = ($now - $certData.NotAfter).Days
        If ($daysSinceLastUse -gt 14) {
            Write-Host "$cert has not been used for more than 14 days."
        }
    }
}

Function Compare-CertificateDetails {
    $certs = Get-ChildItem -Path "C:\certs\" -Filter *.cer | Import-Certificate
    $certDetails = @()

    Foreach ($cert in $certs) {
        $subject = $cert.Subject
        $san = $cert.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Subject Alternative Name" } | Select-Object -ExpandProperty Format(0)
        $ku = $cert.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Key Usage" } | Select-Object -ExpandProperty Format(0)

        $certDetails += [PSCustomObject]@{
            Subject = $subject
            SAN = $san
            KU = $ku
        }
    }

    For ($i = 0; $i -lt $certDetails.Count; $i++) {
        For ($j = $i + 1; $j -lt $certDetails.Count; $j++) {
            Write-Host "Comparing certificate $($i + 1) to certificate $($j + 1):"
            If ($certDetails[$i].Subject -ne $certDetails[$j].Subject) { Write-Host "Subject differs: $($certDetails[$i].Subject) vs $($certDetails[$j].Subject)" }
            If ($certDetails[$i].SAN -ne $certDetails[$j].SAN) { Write-Host "Subject Alternative Name differs: $($certDetails[$i].SAN) vs $($certDetails[$j].SAN)" }
            If ($certDetails[$i].KU -ne $certDetails[$j].KU) { Write-Host "Key Usage differs: $($certDetails[$i].KU) vs $($certDetails[$j].KU)" }
            Write-Host ""
        }
    }
}


Function Combine-Certificates {
    $certs = Get-ChildItem -Path "C:\certs\" -Filter *.cer
    $certs | Export-PfxCertificate -FilePath "C:\certs\master-cert.pfx" -Password (ConvertTo-SecureString -String "password" -Force -AsPlainText)
}

Function Show-CertificateDetails {
    $certs = Get-ChildItem -Path "C:\certs\" -Filter *.cer | Import-Certificate

    Write-Host "Please select which certificate details to display:"
    Write-Host "1. Subject"
    Write-Host "2. Subject Alternative Name"
    Write-Host "3. Key Usage"
    $details = Read-Host "Enter the numbers of the certificate details you would like to display, separated by a comma (e.g. 1,2,3): "

    $details = $details -split ","

    Foreach ($cert in $certs) {
        If ($details -contains "1") { Write-Host "Subject: $($cert.Subject)" }
        If ($details -contains "2") { Write-Host "Subject Alternative Name: $($cert.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Subject Alternative Name" } | Select-Object -ExpandProperty Format(0))" }
        If ($details -contains "3") { Write-Host "Key Usage: $($cert.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Key Usage" } | Select-Object -ExpandProperty Format(0))" }
        Write-Host ""
    }
}

While ($true) {
    Write-Host "Please select a function to run:"
    Write-Host "1. Export Personal Certificates"
    Write-Host "2. Check Certificate Last Use"
    Write-Host "3. Compare Certificate Contents"
    Write-Host "4. Combine Crtificates"
    Write-Host "5. Certificate Details"
    Write-Host "6. Quit Script"
    $function = Read-Host "Enter the number of the function you would like to run: "
    
    Switch ($function) {
        1 { Export-PersonalCertificates }
        2 { Check-CertificateLastUse }
        3 { Compare-CertificateDetails }
        4 { Combine-Certificates }
        5 { Show-CertificateDetail }
        6 { Break }
        Default { Write-Host "Invalid selection. Please try again." }
    }
    
    If ($function -eq 6) {
        Break
    }
}
