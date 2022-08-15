//bModifyRecord 

C_POINTER:C301($tablePtr)
C_TEXT:C284($modifyForm)

$tablePtr:=Current form table:C627
$modifyForm:="Entry"

// change the input form
If (isUserAuthorizedToModify($tablePtr))
	
	modifyRecordTable($tablePtr; $modifyForm)
	
Else 
	myAlert("Sorry, you are not allowed to edit this record."; "Privilege Restriction")
End if 