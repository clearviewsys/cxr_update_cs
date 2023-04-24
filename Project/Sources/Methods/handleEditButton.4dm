//%attributes = {}
//handleEditButton 
// this handler is called from the 'Edit' button in the toolbar.view form 

C_POINTER:C301($tablePtr)
C_TEXT:C284($modifyForm)

$tablePtr:=Current form table:C627
$modifyForm:="Entry"

// change the input form
If (isUserAuthorizedToModify($tablePtr))
	
	Case of   // do we need to override form?
		: ($tablePtr=(->[LinkedDocs:4]))
			If ([LinkedDocs:4]TypeOfDoc:5="*")
				$modifyForm:="Entry_Lite"
			End if 
		Else 
			
	End case 
	
	modifyRecordTable($tablePtr; $modifyForm)
	POST OUTSIDE CALL:C329(Current process:C322)  // this will update some forms or refresh display stamps after the modification is done
Else 
	myAlert("Sorry, you are not allowed to edit this record."; "Privilege Restriction")
End if 