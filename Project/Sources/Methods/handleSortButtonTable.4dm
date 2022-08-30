//%attributes = {}
// handleSortButton(->table;->field;->field2)

C_BOOLEAN:C305(sortOrder)
C_POINTER:C301($1; $2; $3; $tablePtr)
$tablePtr:=$1

If (Count parameters:C259=1)
	If (sortOrder)
		ORDER BY:C49($tablePtr->; $2->; >)
	Else 
		ORDER BY:C49($tablePtr->; $2->; <)
	End if 
Else 
	If (sortOrder)
		ORDER BY:C49($tablePtr->; $2->; >; $3->; >)
	Else 
		ORDER BY:C49($tablePtr->; $2->; <; $3->; >)
	End if 
End if 
sortOrder:=Not:C34(sortOrder)
