# Funktsioon kasutajalt ees- ja perekonnanime küsimiseks
function GetUserData {
    $eesnimi = Read-Host "Please enter user firstname"
    $perenimi = Read-Host "Please enter user lastname"
    return $eesnimi, $perenimi
}

# Funktsioon kontrollib, kas kasutaja eksisteerib AD-s
function UserExists($eesnimi, $perenimi) {
    $kasutajanimi = "$eesnimi.$perenimi"
    $olemasolevKasutaja = Get-ADUser -Filter {SamAccountName -eq $kasutajanimi} -ErrorAction SilentlyContinue
    if ($olemasolevKasutaja -ne $null) {
        return $true
    } else {
        return $false
    }
}

# Funktsioon kasutaja kustutamiseks AD-st
function DeleteUser($eesnimi, $perenimi) {
    $kasutajanimi = "$eesnimi.$perenimi"
    try {
        Remove-ADUser -Identity $kasutajanimi -Confirm:$false -ErrorAction Stop
        Write-Host "User '$kasutajanimi' is removed successfully"
    } catch {
        Write-Host "User does not exist or the problem is occurring during user removal, please try again"
    }
}

# Küsi kasutajalt ees- ja perenime
$eesnimi, $perenimi = GetUserData

# Kontrolli, kas kasutaja eksisteerib, seejärel kustuta, kui leitud
if (UserExists $eesnimi $perenimi) {
    DeleteUser $eesnimi $perenimi
} else {
    Write-Host "User does not exist or the problem is occurring during user removal, please try again"
}
