##Filtreerib kogu protsesside nimekirjast välja notepadi ning tagastab selle id
Get-Process | ?{$_.ProcessName -eq "notepad"} | Select ProcessName,Id

##Valime kauta asukoha
Get-ChildItem -Path "C:\temp\test"
##Filtreerib .csv mustri järgi failid
$file = Get-ChildItem -Path "C:\temp\test" | Where-Object {$_.Name -like "*.csv"} | Select-Object Name, Length
##Arvutab failide suurused
$sizeinKB = $file.Length/1KB
$sizeinMB = $file.Length/1MB
##Tulemuste väljund
Write-Host "`nFileName : "$file.Name
Write-Host "Size in KB : "$sizeinKB
Write-Host "Size in MB : "$sizeinMB