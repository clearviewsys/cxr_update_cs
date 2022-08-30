C_POINTER:C301($tablePtr)
C_TEXT:C284($modifyForm)

$tablePtr:=Current form table:C627
$modifyForm:="Entry"

// change the input form
If (isUserAuthorizedToModify($tablePtr))
	//READ WRITE($tablePtr->)
	//FORM SET INPUT($tablePtr->;$modifyForm)
	//
	//$WinRef:=Open form window($tablePtr->;$modifyForm;Plain window;Horizontally Centered;Vertically Centered;*)
	//MODIFY RECORD($tablePtr->;*)
	
	modifyRecordTable($tablePtr; $modifyForm)
	
	REDRAW WINDOW:C456
Else 
	myAlert("Sorry, you are not allowed to edit this record."; "Privilege Restriction")
End if 