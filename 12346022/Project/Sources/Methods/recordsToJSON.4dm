//%attributes = {}
C_TEXT:C284($0)
C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($2; $whatToExport)  // "ALL|SELECTION"
C_COLLECTION:C1488($col)

$tablePtr:=$1

If (Count parameters:C259>1)
	$whatToExport:=$2
Else 
	$whatToExport:="SELECTION"
End if 

$col:=recordsToCollection($tablePtr; $whatToExport)

If ($col#Null:C1517)
	$0:=JSON Stringify:C1217($col)
End if 
