##Skript loendab protsesse
$ct1 = 0
##Skript on sisult sarnane practice 9 omaga, aga kasutab Do While asemel Do Until
##Do Until töötab kuni tingimus on täidetud
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
}until($ct2 -eq 1)
$ct1