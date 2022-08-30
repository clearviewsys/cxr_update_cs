//%attributes = {}
C_TEXT:C284($1; $JSON)
C_POINTER:C301($2; $tablePtr)

$JSON:=$1
$tablePtr:=$2

C_COLLECTION:C1488($col)  // expecting collection in JSON
C_OBJECT:C1216($record)

$col:=JSON Parse:C1218($json)

For each ($record; $col)
	
	CREATE RECORD:C68($tablePtr->)
	objToRecord($record; $tablePtr)
	SAVE RECORD:C53($tablePtr->)
	
End for each 
