//%attributes = {}
// findAndReplace(->table;->fieldtofind;->valuetoFind;->fieldToReplace;->valueToreplace) : recordsFound(int)
// this method search for fieldvalue and replace another field (or same) with another value
// this method is useful to search for an ewire by ID and reassign its invoice number to the currenct invoice 

// see ALSO: findAndReplaceString

C_POINTER:C301($1; $2; $3; $4; $5)
C_POINTER:C301($tablePtr; $fieldToFindPtr; $valueToFindPtr; $fieldToReplacePtr; $valueToReplacePtr)
C_LONGINT:C283($recordsFound; $0; $i)

$tablePtr:=$1
$fieldToFindPtr:=$2
$valueToFindPtr:=$3
$fieldToReplacePtr:=$4
$valueToReplacePtr:=$5

READ WRITE:C146($tablePtr->)
QUERY:C277($tablePtr->; $fieldToFindPtr->=$valueToFindPtr)
$recordsFound:=Records in selection:C76($tablePtr->)
If ($recordsFound>0)
	FIRST RECORD:C50($tablePtr->)
	For ($i; 1; Records in selection:C76($tablePtr->))
		LOAD RECORD:C52($tablePtr->)
		$fieldToReplacePtr->:=$valueToReplacePtr->
		SAVE RECORD:C53($tablePtr->)
		NEXT RECORD:C51($tablePtr->)
	End for 
	UNLOAD RECORD:C212($tablePtr->)
End if 
READ ONLY:C145($tablePtr->)
$0:=$recordsFound