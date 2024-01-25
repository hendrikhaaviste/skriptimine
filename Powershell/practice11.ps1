##Skrip võtab sisendiks 2 arvu ning teeb 4 erinevat tehet, kasutaja valikul
[int]$n1 = Read-Host "Enter first number"
[int]$n2 = Read-Host "Enter second number"
##Peale 2 arvu sisendit, saad valida valemi
Write-Host "Calculator" -ForegroundColor Green
Write-Host "1: Addition" -ForegroundColor Yellow
Write-Host "2: Subtraction" -ForegroundColor Yellow
Write-Host "3: Division" -ForegroundColor Yellow
Write-Host "4: Multiplication" -ForegroundColor Yellow
$ch = Read-Host "Enter your choice"
##Liitmise valem
switch($ch)
{
1
{
$s = $n1+$n2
Write-Host "Sum is : "$s
}
2
{
##Lahutuse valem
$s = $n1-$n2
Write-Host "Difference is : "$s
}
3
{
##Jagamise valem
$s = $n1/$n2
Write-Host "Quotient is : "$s
}
4
{
##Korrutuse valem
$s = $n1*$n2
Write-Host "Product is : "$s
}
}