//%attributes = {}
// returns collection of all collections containing $k number of items from $col

#DECLARE($col : Collection; $k : Integer)->$combinations : Collection

var $tmp : Collection

$combinations:=New collection:C1472
$tmp:=New collection:C1472

getAllColCombinationsUtil($col.length; 1; $k; $combinations; $tmp; $col)
