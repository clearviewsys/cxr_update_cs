//%attributes = {}
// handlePickFormListBox(->listbox; ->searchVar; ->table; ->field)
// This is the object method to be called from a listbox inside a pick form
// this is new version after 3.601

C_POINTER:C301($1; $listBoxPtr)
C_POINTER:C301($2; $searchVarPtr)
C_POINTER:C301($3; $tablePtr)
C_POINTER:C301($4; $fieldPtr)

$listBoxPtr:=$1
$searchVarPtr:=$2
$tablePtr:=$3
$fieldPtr:=$4

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29) | (Form event code:C388=On Double Clicked:K2:5))
	$searchVarPtr->:=listbox_getSelectedRecordField($listBoxPtr; $tablePtr; $fieldPtr)
End if 
