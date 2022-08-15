//%attributes = {}
// RemoveCurrentRecordFromSelection (->Table)

C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283($2; $recordNumber)

C_TEXT:C284($setName)
$tablePtr:=$1
$recordNumber:=$2

$setName:="setOf"+Table name:C256($tablePtr)

CREATE SET:C116($tablePtr->; $setName)

REMOVE FROM SET:C561($tablePtr->; $setName)

USE SET:C118($setName)

CLEAR SET:C117($setName)