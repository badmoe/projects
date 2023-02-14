# Function to export personal certificates to C:\certs\
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
        $filename = $cert.Subject.Replace(" ", "_") + "_" + $cert.SerialNumber.Substring($cert.SerialNumber.Length - 4) + ".cer"
        $cert | Export-Certificate -Type CERT -FilePath "C:\certs\$filename"
    }
}

# Function to check certificates last use
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

# Function to compare certificate contents
Function Compare-CertificateContents {
    $certs = Get-ChildItem -Path "C:\certs\"
    
    For ($i = 0; $i -lt $certs.Count; $i++) {
        For ($j = $i + 1; $j -lt $certs.Count; $j++) {
            $cert1 = Get-PfxCertificate -FilePath $certs[$i].FullName
            $cert2 = Get-PfxCertificate -FilePath $certs[$j].FullName
            
            If ($cert1.Subject -ne $cert2.Subject) {
                Write-Host "Subject Name differences: $($certs[$i].Name) vs $($certs[$j].Name)"
            }
            
            If ($cert1.Issuer -ne $cert2.Issuer) {
                Write-Host "Issuer Name differences: $($certs[$i].Name) vs $($certs[$j].Name)"
            }
            
            If ($cert1.SerialNumber -ne $cert2.SerialNumber) {
                Write-Host "Serial Number differences: $($certs[$i].Name) vs $($certs[$j].Name)"
            }
            
            If ($cert1.Thumbprint -ne $cert2.Thumbprint) {
                Write-Host "Thumbprint differences: $($certs[$i].Name) vs $($certs[$j].Name)"
            }
        }
    }
}

# Function to combine all certificates into one "master-cert.pfx"
Function Combine-Certificates {
    $certs = Get-ChildItem -Path "C:\certs\" -Filter *.cer
    $certs | Export-PfxCertificate -FilePath "C:\certs\master-cert.pfx" -Password (ConvertTo-SecureString -String "password" -Force -AsPlainText)
}


# Main loop to prompt the user for a function to run
While ($true) {
    Write-Host "Please select a function to run:"
    Write-Host "1. Export Personal Certificates"
    Write-Host "2. Check Certificate Last Use"
    Write-Host "3. Compare Certificate Contents"
    Write-Host "4. Combine Scripts"
    Write-Host "5. Quit Script"
    $function = Read-Host "Enter the number of the function you would like to run: "
    
    Switch ($function) {
        1 { Export-PersonalCertificates }
        2 { Check-CertificateLastUse }
        3 { Compare-CertificateContents }
        4 { Combine-Certificates }
        5 { Break }
        Default { Write-Host "Invalid selection. Please try again." }
    }
    
    If ($function -eq 5) {
        Break
    }
}
