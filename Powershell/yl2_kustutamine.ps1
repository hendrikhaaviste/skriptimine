# Funktsioon kasutajanime loomiseks
function LoomeKasutajanimi {
    param (
        [string]$eesnimi,
        [string]$perenimi
    )

    $kasutajanimi = "$($eesnimi.ToLower()).$($perenimi.ToLower())"
    return $kasutajanimi
}

# Funktsioon kasutaja olemasolu kontrollimiseks
function KasutajaEksisteerib {
    param (
        [string]$kasutajanimi
    )

    $existingUser = Get-WmiObject -Class Win32_UserAccount -Filter "Name='$kasutajanimi'" -ErrorAction SilentlyContinue
    return $existingUser -ne $null
}

# Küsime kasutajalt eesnime
$eesnimi = Read-Host "Sisesta oma eesnimi"

# Küsime kasutajalt perenime
$perenimi = Read-Host "Sisesta oma perenimi"

# Loome kasutajanime
$kasutajanimi = LoomeKasutajanimi -eesnimi $eesnimi -perenimi $perenimi

# Muudame veateadete kuvamise taset, et mitte kuvada punast errorit
$ErrorActionPreference = "Stop"

# Kontrollime, kas kasutaja eksisteerib
try {
    if (KasutajaEksisteerib $kasutajanimi) {
        # Kustutame kasutaja cmd.exe kaudu, kuna WIM ei lasknud kustutada
        $result = cmd.exe /c "net user $kasutajanimi /delete"

        if ($result -like "The command completed successfully.") {
            Write-Host "Kustutatav kasutaja on $kasutajanimi"
            Write-Host "Kasutaja $kasutajanimi on kustutatud."
        } else {
            Write-Host "Kustutatav kasutaja on $kasutajanimi"
            Write-Host "Tekkinud probleem kasutaja kustutamisega: $result"
        }
    } else {
        Write-Host "Kustutatav kasutaja on $kasutajanimi"
        Write-Host "Tekkinud probleem kasutaja kustutamisega"
    }
}
catch {
    # Veateade muude probleemide tõttu
    Write-Host "Kustutatav kasutaja on $kasutajanimi"
    Write-Host "Tekkinud probleem kasutaja kustutamisega: $_"
}

# Taastame veateadete kuvamise taseme tagasi "Continue"-ks
$ErrorActionPreference = "Continue"
