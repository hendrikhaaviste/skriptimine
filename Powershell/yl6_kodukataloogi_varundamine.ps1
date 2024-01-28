# Loome kausta varunduste jaoks
$backupFolder = "C:\Backup"
New-Item -ItemType Directory -Path $backupFolder -ErrorAction SilentlyContinue

# Funktsioon kodukataloogi varundamiseks
Function Backup-UserHomeDirectory {
    param (
        [string]$username
    )

    # Konstrueerime varundusfaili nime
    $backupFileName = "$backupFolder\$username-$((Get-Date).ToString('yy.MM.yyyy')).zip"

    # Varundame kodukataloogi ZIP-faili
    Compress-Archive -Path "\\server\$username" -DestinationPath $backupFileName -ErrorAction SilentlyContinue

    # Kontrollime, kas varundus õnnestus
    if (Test-Path $backupFileName) {
        Write-Host "Kasutaja kodukataloogi varundamine kasutajale $username õnnestus."
    } else {
        Write-Host "Kasutaja kodukataloogi varundamine kasutajale $username ebaõnnestus."
    }
}

# Funktsioon kõikide kasutajate kodukataloogide varundamiseks
Function Backup-AllUserHomeDirectories {
    # Hangime kõik kasutajad
    $allUsers = Get-ADUser -Filter *
    
    foreach ($user in $allUsers) {
        Backup-UserHomeDirectory -username $user.SamAccountName
    }
}

# Varundame kõikide kasutajate kodukataloogid
Backup-AllUserHomeDirectories
