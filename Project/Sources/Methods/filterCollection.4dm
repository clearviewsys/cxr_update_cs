//%attributes = {}
// filterCollection ( value ; collection ; $isIn:Boolean ) 
C_OBJECT:C1216($1; $value)
C_COLLECTION:C1488($2; $col)
C_BOOLEAN:C305($3; $isIn)

$value:=$1
$col:=$2
$isIn:=$3

If ($isIn)  // want ones that ARE in $2
	$value.result:=($col.indexOf($value.value)>-1)
Else   // want ones that ARE NOT in $2
	$value.result:=($col.indexOf($value.value)<0)
End if 
