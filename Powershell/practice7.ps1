##Skript jaotab tundengid värvide järgi
$groups = @("Red", "Green", "Yellow", "Blue")

$result = @()

##Alustame tsükliga, mis võtab kuni 20 arvu
for ($i = 1; $i -le 20; $i++) {
##Saame juhusliku värvivaliku grupist $groups
    $g = Get-Random $groups
    
##Loome ajutise objekti, kus on tundengi rolli number ja värvi grupeering
    $temp = [PSCustomObject]@{
        RollNumber = $i
        Group = $g
    }
    
    $result += $temp
}

## Väljastame tulemuse
$result
