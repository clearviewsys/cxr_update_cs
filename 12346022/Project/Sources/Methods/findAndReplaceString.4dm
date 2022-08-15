//%attributes = {}
// findAndReplaceString (->table;->fieldtofind;valuetoFind;->fieldToReplace;valueToreplace) : recordsFound(int)

C_POINTER:C301($1; $2; $4)
C_TEXT:C284($3; $5)

C_POINTER:C301($tablePtr; $fieldToFindPtr; $valueToFindPtr; $fieldToReplacePtr; $valueToReplacePtr)
C_TEXT:C284($stringToFind; $stringToReplace)

C_LONGINT:C283($recordsFound; $0; $i)

$tablePtr:=$1
$fieldToFindPtr:=$2
$stringToFind:=$3
$fieldToReplacePtr:=$4
$stringToReplace:=$5

READ WRITE:C146($tablePtr->)
QUERY:C277($tablePtr->; $fieldToFindPtr->=$stringToFind)
$recordsFound:=Records in selection:C76($tablePtr->)
If ($recordsFound>0)
	FIRST RECORD:C50($tablePtr->)
	LOAD RECORD:C52($tablePtr->)
	For ($i; 1; Records in selection:C76($tablePtr->))
		$fieldToReplacePtr->:=$stringToReplace
		SAVE RECORD:C53($tablePtr->)
		NEXT RECORD:C51($tablePtr->)
	End for 
	UNLOAD RECORD:C212($tablePtr->)
End if 
READ ONLY:C145($tablePtr->)
$0:=$recordsFound