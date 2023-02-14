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

Function Combine-Certificates {
    $certs = Get-ChildItem -Path "C:\certs\" -Filter *.cer
    $certs | Export-PfxCertificate -FilePath "C:\certs\master-cert.pfx" -Password (ConvertTo-SecureString -String "password" -Force -AsPlainText)
}

Function Get-CertificateInfo {
    $certStorePath = Read-Host "Check certificates in the current user's personal store (1) or the local machine's personal store (2)? (1/2)"
    if ($certStorePath -eq "1") {
        $certStorePath = "Cert:\CurrentUser\My"
    }
    elseif ($certStorePath -eq "2") {
        $certStorePath = "Cert:\LocalMachine\My"
    }

    $certs = Get-ChildItem -Path $certStorePath

    $certInfo = @()

    Foreach ($cert in $certs) {
        $serial = $cert.SerialNumber
        $subject = $cert.Subject
        $san = $cert.SubjectAltName

        $certInfo += [PSCustomObject]@{
            Serial = $serial
            Subject = $subject
            SAN = $san
        }
    }

    Foreach ($info in $certInfo) {
        Write-Host "Certificate Serial: $($info.Serial.Substring($info.Serial.Length - 6))"
        Write-Host "Subject: $($info.Subject)"
        Write-Host "Subject Alternative Name: $($info.SAN)"
        Write-Host "------------------------------------"
    }
}

Function Get-CertificateChainSerials {
    $certStorePath = Read-Host "Check certificates in the current user's personal store (1) or the local machine's personal store (2)? (1/2)"
    if ($certStorePath -eq "1") {
        $certStorePath = "Cert:\CurrentUser\My"
    }
    elseif ($certStorePath -eq "2") {
        $certStorePath = "Cert:\LocalMachine\My"
    }

    $certs = Get-ChildItem -Path $certStorePath

    Foreach ($cert in $certs) {
        Write-Host "Certificate: $($cert.SerialNumber.Substring($cert.SerialNumber.Length - 6))"
        $chain = $cert.Chain
        Foreach ($c in $chain) {
            Write-Host "  Chain: $($c.SerialNumber.Substring($c.SerialNumber.Length - 6))"
        }
        Write-Host "------------------------------------"
    }
}

While ($true) {
    Write-Host "Please select a function to run:"
    Write-Host "1. Export Personal Certificates"
    Write-Host "2. Combine Certificates"
    Write-Host "3. Output Details of Personal Certificates"
    Write-Host "4. Check serials of Personal Certificate Chains"
    Write-Host "0. Quit Script"
    $function = Read-Host "Enter the number of the function you would like to run: "
    
    Switch ($function) {
        1 { Export-PersonalCertificates }
        2 { Combine-Certificates }
        3 { Get-CertificateInfo }
        4 { Get-CertificateChainSerials }
        0 { Break }
        Default { Write-Host "Invalid selection. Please try again." }
    }
    
    If ($function -eq 0) {
        Break
    }
}
