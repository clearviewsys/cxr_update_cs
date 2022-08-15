//%attributes = {}
// editRecords (->table)

C_POINTER:C301($tablePtr; $1)
$tablePtr:=$1

C_TEXT:C284($modifyForm)
$modifyForm:="Entry"

If (isUserAuthorizedToModify($tablePtr))
	
	
	//READ WRITE($tablePtr->)
	//If (Records in selection($tablePtr->)>0)
	//$WinRef:=Open form window($tablePtr->;$modifyForm;Plain window;Horizontally Centered;Vertically Centered;*)
	//
	//MODIFY RECORD($tablePtr->;*)
	//CLOSE WINDOW
	//End if 
	//READ ONLY($tablePtr->)
	
	modifyRecordTable($tablePtr; $modifyForm)
	
Else 
	myAlert("You are not authorized to edit records on this table.")
End if 