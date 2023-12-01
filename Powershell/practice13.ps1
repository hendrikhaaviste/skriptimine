##Skript arvutab kujundite valemeid arvestades kasutaja sisendeid

##Kuna Powershellis ei näita värvi alati õigesti, siis siin on eraldi funktsioon selleks
function Write-ColoredText {
    param (
        [string]$text,
        [string]$color
    )
    Write-Host $text -ForegroundColor $color
}
##Menüü, millest saame oma kujundi valida
function mainmenu {
    Write-ColoredText "`t`t`tArea Calculator" Green
    Write-ColoredText "`n`t`t`tMain Menu" Yellow
    Write-ColoredText "`nPlease select the option to perform the respective task`n" Yellow
    Write-ColoredText "1: Area of Square" Green
    Write-ColoredText "2: Area of Rectangle" Green
    Write-ColoredText "3: Area of Circle" Green
    Write-ColoredText "4: Area of Triangle" Green
    Write-ColoredText "5: Exit`n" Green
    $choice = Read-Host "Enter your choice"
    return $choice
}
##Kontroll meie valiku üle
do {
    cls
    $ch1 = mainmenu
    switch ($ch1) {
        1 { cls; square; checkmenu }
        2 { cls; rectangle; checkmenu }
        3 { cls; circle; checkmenu }
        4 { cls; triangle; checkmenu }
    }
} while ($ch1 -ne "5")

##Siit saame veel edasisi sisendeid
function checkmenu
{
Write-Host "`n`nPlease select the next option" -ForegroundColor Yellow
Write-Host "`n1: Return to Main Menu" -ForegroundColor Green
Write-Host "2: Exit`n" -ForegroundColor Green
$ch2 = Read-Host "Enter your choice"
if($ch2 -eq "1")
{
continue
}
if($ch2 -eq "2")
{
exit
}
else
{
Write-Host "`nEnter correct option" -ForegroundColor Red
checkmenu
}
}
##Ruudu pindala arvutus
function square
{
cls
Write-Host "`t`t`tArea of Square`n" -ForegroundColor Green
[int]$side = Read-Host "Enter the side of the square"
$area = $side * $side
Write-Host "`nArea of the square : "$area -ForegroundColor Green
checkmenu
}
##Ristküliku pindala arvutus
function rectangle
{
cls
Write-Host "`t`tArea of Rectangle`n" -ForegroundColor Green
[int]$length = Read-Host "Enter length of the rectangle"
[int]$breadth = Read-Host "Enter breadth of the rectangle"
$area = $length * $breadth
Write-Host "`nArea of the rectangle : "$area -ForegroundColor Green
checkmenu
}
##Ringi pindala arvutus
function circle
{
cls
Write-Host "`t`tArea of Circle`n" -ForegroundColor Green
[int]$radius = Read-Host "Enter the radius of the circle"
$area = 3.14*$radius*$radius
Write-Host "`nArea of the circle : "$area -ForegroundColor Green
checkmenu
}
##Kolmnurga pindala arvutus
function triangle
{
cls
Write-Host "`t`tArea of Triangle`n" -ForegroundColor Green
[int]$height = Read-Host "Enter height of triangle"
[int]$base = Read-Host "Enter base of triangle"
$area = 0.5*$height*$base
Write-Host "`nArea of Triangle : "$area -ForegroundColor Green
checkmenu
}
##See osa käivitab skripti kuni skripti väljumiseni
do
{
cls
$ch1 = mainmenu
switch($ch1)
{
1
{
cls
square
checkmenu
}
2 { cls rectangle checkmenu } 3 { cls circle checkmenu } 4 { cls triangle checkmenu }
}
}while($ch1 -ne "5")