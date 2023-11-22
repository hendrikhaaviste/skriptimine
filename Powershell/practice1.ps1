#Skript arvutab 2 array positsioonidel olevaid arve

$array1 = @(1,2,3)
$array2 = @(4,5,6)

$array3 = @() ##tühi array

##võtab mõlema array 0 positsioonil arvu ja liidab, teiste puhul võtab järgmised positsioonid
$array3 += $array1[0] + $array2[0]
$array3 += $array1[1] + $array2[1]
$array3 += $array1[2] + $array2[2]

$array3 ##väljastab arvud