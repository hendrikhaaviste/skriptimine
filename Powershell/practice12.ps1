##Skripti esimene pool kasutab funktsioone ilma parameetrita, et leida jooksvaid ja seisvaid serviceid
##Leiab jooksval seisul
function countstart
{
$start = Get-Service | ?{$_.Status -eq "Running"}
Write-Host "Total services in running state = "$start.count
}
##Leiab seisval seisul
function countstop
{
$stop = Get-Service | ?{$_.Status -eq "Stopped"}
Write-Host "Total services in stopped state = "$stop.count
}
countstart
countstop
##Skripti teine pool leiab serviceid kasutades parameetreid
function countservice
{
##Parameeter staatusega "Running"
param
(
[string]$status
)
if($status -eq "Running")
{
$start = Get-Service | ?{$_.Status -eq "Running"}
Write-Host "Total services in running state = "$start.count
}
##Parameeter taatusega "Stopped"
elseif($status -eq "Stopped")
{
$stop = Get-Service | ?{$_.Status -eq "Stopped"}
Write-Host "Total services in stopped state = "$stop.count
}
}
countservice -status Running
countservice -status Stopped