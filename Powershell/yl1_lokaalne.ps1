# Lisa vajalik .NET raamistik
Add-Type -AssemblyName System.DirectoryServices.AccountManagement

# Loome funktsiooni nime kontrollimiseks
function KontrolliNime {
    param (
        [string]$nimi
    )

    # Regulaaravaldis, mis lubab ainult ladina tähti
    $ladinaRegex = '^[a-zA-Z]+$'

    if ($nimi -match $ladinaRegex) {
        return $true
    } else {
        return $false
    }
}

# Funktsioon kasutajanime loomiseks
function LoomeKasutajanimi {
    param (
        [string]$eesnimi,
        [string]$perenimi
    )

    $kasutajanimi = "$($eesnimi.ToLower()).$($perenimi.ToLower())"
    return $kasutajanimi
}

# Küsime kasutajalt eesnime
$eesnimi = Read-Host "Sisesta oma eesnimi"

# Kontrollime eesnime ladina tähtede osas
while (-not (KontrolliNime $eesnimi)) {
    Write-Host "Eesnimi võib sisaldada ainult ladina tähti!"
    $eesnimi = Read-Host "Sisesta oma eesnimi"
}

# Küsime kasutajalt perenime
$perenimi = Read-Host "Sisesta oma perenimi"

# Kontrollime perenime ladina tähtede osas
while (-not (KontrolliNime $perenimi)) {
    Write-Host "Perenimi võib sisaldada ainult ladina tähti!"
    $perenimi = Read-Host "Sisesta oma perenimi"
}

# Loome kasutajanime
$kasutajanimi = LoomeKasutajanimi -eesnimi $eesnimi -perenimi $perenimi

# Muudame veateadet, et mitte kuvada punast errorit
$ErrorActionPreference = "Stop"

# Kontrollime, kas kasutaja on juba olemas
$kasutajaOlemas = $false
try {
    $kontekst = New-Object DirectoryServices.AccountManagement.PrincipalContext([DirectoryServices.AccountManagement.ContextType]::Machine)
    $existingUser = [DirectoryServices.AccountManagement.UserPrincipal]::FindByIdentity($kontekst, $kasutajanimi)
    if ($existingUser -ne $null) {
        $kasutajaOlemas = $true
    }
}
catch {
    # Ei tee midagi, kuna eeldame, et kasutaja ei ole veel loodud
}

# Proovime luua kasutaja ainult siis, kui ta veel ei eksisteeri
if (-not $kasutajaOlemas) {
    try {
        # Loome kasutaja
        $uus_kasutaja = New-Object DirectoryServices.AccountManagement.UserPrincipal($kontekst, $kasutajanimi, "Parool1!", $true)
        $uus_kasutaja.Enabled = $true
        $uus_kasutaja.Save()

        # Väljastame teate kasutajanime ja täisnimega
        Write-Host "Loodav kasutaja on $kasutajanimi"
        Write-Host "Parooliks on määratud: Parool1!"
    }
    catch {
        # Kuvame omaenda veateade, kui midagi muud läheb valesti
        Write-Host "Viga kasutaja loomisel: $_"
    }
}
else {
    # Kuvame omaenda veateade, kui kasutaja on juba olemas
    Write-Host "Tekkinud probleem kasutaja loomisega"
    Write-Host "Loodav kasutaja on $kasutajanimi"
}

# Taastame veateadete kuvamise taset tagasi "Continue"-ks
$ErrorActionPreference = "Continue"
