//%attributes = {}
// handleFilterRecords(->table)
// this method filters the records of a table according to the user selection
// The subtable must be "multple" line selectable

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($setName)
$tablePtr:=$1
$setName:="$"+Table name:C256($tablePtr)
GET HIGHLIGHTED RECORDS:C902($tablePtr->; $setName)
If (Records in set:C195($setName)>0)
	USE SET:C118($setName)
	HIGHLIGHT RECORDS:C656($tablePtr->; $setName)
End if 
CLEAR SET:C117($setName)