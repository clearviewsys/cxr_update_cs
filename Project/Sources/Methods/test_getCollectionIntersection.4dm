//%attributes = {}
var $col1; $col2; $col3 : Collection

$col2:=New collection:C1472("USD"; "EUR"; "MXN"; "CAD")
$col1:=New collection:C1472("EUR"; "GBP")

$col3:=getCollectionIntersection($col1; $col2)
