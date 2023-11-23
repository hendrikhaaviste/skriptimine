##Skript võrdleb, kumb arv on suurem
$value1 = Read-Host "Enter the first value"
$value2 = Read-Host "Enter the second value"
if($value1 -gt $value2)
{
Write-Host "The higher number is : "$value1
}
else
{
Write-Host "The higher number is : "$value2
}

##Teine osa skriptist annab vastavalt numbrile riigi pealinna
Write-Host "Select Country" -ForegroundColor Yellow
Write-Host "1 : India" -ForegroundColor Cyan
Write-Host "2: Australia" -ForegroundColor Cyan
Write-Host "3: China" -ForegroundColor Cyan
$choice = Read-Host "Please select country"
if($choice -eq "1")
{
Write-Host "India's captital is New Delhi" -ForegroundColor Green
}
elseif($choice -eq "2")
{
Write-Host "Australia's capital is Canberra" -ForegroundColor Green
}
elseif($choice -eq "3") {
Write-Host "China's capital is Beijing" -ForegroundColor Green
}
else
{
Write-Host "Wrong choice" -ForegroundColor Red
}