##Skript, mis annab teada kui kaua töötas notepad
$ct1 = 0
##Skript loendab protsesse ning määratud intervall 1 sekundiga
do
{
$ch = $null
$ch = Get-Process | ?{$_.name -like "note*"}
if($ch -ne $null)
{$ct2 = 2
Write-Host "Notepad is running"
Start-Sleep -Seconds 1
$ct1++
}
else
{$ct2 = 1}
}while($ct2 -ne 1)
$ct1