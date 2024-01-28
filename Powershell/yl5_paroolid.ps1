# Funktsioon tugeva parooli genereerimiseks
Function GenerateStrongPassword {
    param (
        [Parameter(Mandatory=$true)][int]$PasswordLength
    )

    Add-Type -AssemblyName System.Web
    $PassComplexCheck = $false
    do {
        $newPassword = [System.Web.Security.Membership]::GeneratePassword($PasswordLength,1)
        If ( ($newPassword -cmatch "[A-Z\p{Lu}\s]") `
        -and ($newPassword -cmatch "[a-z\p{Ll}\s]") `
        -and ($newPassword -match "[\d]") `
        -and ($newPassword -match "[^\w]")
        ) {
            $PassComplexCheck=$True
        }
    } While ($PassComplexCheck -eq $false)
    return $newPassword
}

# Funktsioon kontrollimiseks, kas kasutaja juba eksisteerib
Function KasutajaEksisteerib {
    param (
        [string]$kasutajanimi
    )

    $existingUser = Get-ADUser -Filter {SamAccountName -eq $kasutajanimi} -ErrorAction SilentlyContinue
    return $existingUser -ne $null
}

# Funktsioon kasutaja loomiseks
Function Create-User {
    param (
        [string]$eesnimi,
        [string]$perenimi
    )
    
    $kasutajanimi = $eesnimi.ToLower() + "." + $perenimi.ToLower()
    
    # Kontrolli, kas kasutajanimi juba eksisteerib
    if (KasutajaEksisteerib($kasutajanimi)) {
        Write-Host "Kasutaja $kasutajanimi on juba olemas."
        return
    }
    
    $parool = GenerateStrongPassword -PasswordLength 12
    
    # Loo uus kasutaja AD-s
    New-ADUser -SamAccountName $kasutajanimi -GivenName $eesnimi -Surname $perenimi -AccountPassword (ConvertTo-SecureString -AsPlainText $parool -Force) -Name "$eesnimi $perenimi"

    # Salvesta kasutaja andmed CSV faili kasutaja profiilikausta Dokumendid alamkausta
    $kasutajaAndmed = [PSCustomObject]@{
        Kasutajanimi = $kasutajanimi
        Parool = $parool
    }
    $kasutajaAndmed | Export-Csv -Path "$env:USERPROFILE\Documents\$kasutajanimi.csv" -NoTypeInformation

    # Väljasta teade kasutaja loomise kohta
    Write-Host "Kasutaja $eesnimi.$perenimi on loodud."
}

# Küsi kasutajalt ees- ja perenime
$eesnimi = Read-Host "Sisesta oma eesnimi"
$perenimi = Read-Host "Sisesta oma perenimi"

# Looge kasutaja ja salvestage andmed CSV faili
Create-User -eesnimi $eesnimi -perenimi $perenimi
