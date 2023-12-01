##Skript võtab csv faili ning teeb jaotab tudengid gruppidesse
$csv = Import-Csv C:\temp\students.csv

$result = @()
##Tsükkel kontrollib vanuseid ning annab vahemikus 4-10 "Junior" ja 11-17 "Senior"
foreach ($c in $csv) {
    if ([int]$c.Age -ge 4 -and [int]$c.Age -le 10) {
        $school = "Junior"
    } elseif ([int]$c.Age -ge 11 -and [int]$c.Age -le 17) {
        $school = "Senior"
    }
##Loob ajutise objekti, mis sisaldavad väärtuseid
    $temp = [PSCustomObject]@{
        Name = $c.Name
        School = $school
    }
    $result += $temp
}
##Tagastab tulemused
$result
