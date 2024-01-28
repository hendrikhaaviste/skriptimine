# Funktsioon, mis kontrollib, kas kasutaja on juba olemas AD-s
function KasutajaOlemas([string]$kasutajanimi) {
    $existingUser = Get-ADUser -Filter {SamAccountName -eq $kasutajanimi} -ErrorAction SilentlyContinue
    return $existingUser -ne $null
}

# Küsime kasutajalt eesnime
$eesnimi = Read-Host "Sisesta oma eesnimi"

# Kontrollime eesnime ladina tähtede osas
while (-not ($eesnimi -match "^[a-zA-Z]+$")) {
    Write-Host "Eesnimi võib sisaldada ainult ladina tähti!"
    $eesnimi = Read-Host "Sisesta oma eesnimi"
}

# Küsime kasutajalt perenime
$perenimi = Read-Host "Sisesta oma perenimi"

# Kontrollime perenime ladina tähtede osas
while (-not ($perenimi -match "^[a-zA-Z]+$")) {
    Write-Host "Perenimi võib sisaldada ainult ladina tähti!"
    $perenimi = Read-Host "Sisesta oma perenimi"
}

# Loome kasutajanime
$kasutajanimi = $eesnimi.ToLower() + "." + $perenimi.ToLower()

# Kontrollime, kas kasutaja eksisteerib juba
if (KasutajaOlemas($kasutajanimi)) {
    Write-Host "User $kasutajanimi already exists - can not add this user"
} else {
    # Lisa uus kasutaja AD-sse
    New-ADUser -SamAccountName $kasutajanimi -GivenName $eesnimi -Surname $perenimi
    if ($?) {
        Write-Host "New user $kasutajanimi added successfully"
    } else {
        Write-Host "Failed to add user $kasutajanimi"
    }
}
