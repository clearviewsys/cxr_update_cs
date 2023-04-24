//%attributes = {"shared":true}
// display_ListboxForm (->table;form)
// this method displays the form which contains a listbox

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($form; $2)

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
		$form:="ListBox"
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$form:=$2
	Else 
		$tablePtr:=->[Customers:3]
		$form:="ListBox"
End case 


checkInit
checkAddErrorIf(Not:C34(isModuleAuthorized($tablePtr)); getElegantTableName($tablePtr)+" cannot be viewed with this license.")
checkAddErrorIf(Not:C34(isUserAuthorizedToView($tablePtr)); "Sorry, you are not authorized to view this module.")

If (isValidationConfirmed)
	READ ONLY:C145($tablePtr->)
	
	openFormWindow($tablePtr; $form)
End if 