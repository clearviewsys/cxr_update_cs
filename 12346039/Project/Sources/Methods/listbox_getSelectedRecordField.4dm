//%attributes = {}
// getSelectedListBoxRecord(->listboxptr;->table;->textfieldPtr) :string
// returns the field value of a listbox selected row
// this method is used in the picker 
C_POINTER:C301($listBoxPtr; $tablePtr; $fieldPtr; $1; $2)
C_TEXT:C284($0; $recordID)
$listBoxPtr:=$1
$tablePtr:=$2
$fieldPtr:=$3

C_LONGINT:C283($col; $row)
LISTBOX GET CELL POSITION:C971($listBoxPtr->; $col; $row)
If ($row>=1)
	GOTO SELECTED RECORD:C245($tablePtr->; $row)
	READ ONLY:C145($tablePtr->)  // newly added in version 3.601
	LOAD RECORD:C52($tablePtr->)  // load the reocrd
	$recordID:=$fieldPtr->  // point to the ID
	$0:=$recordID
Else 
	$0:=""
End if 
