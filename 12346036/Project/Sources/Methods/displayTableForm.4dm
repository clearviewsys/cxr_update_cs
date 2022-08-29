//%attributes = {"shared":true}
// displayTableForm (->[TABLE]; form)
// this method is an alternative to displaylist. This is more for opening forms that contain listboxes (e.g. tellerproof,etc.)


C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($formName; $2)

$tablePtr:=$1
$formName:=$2

checkInit
checkAddErrorIf(Not:C34(isModuleAuthorized($tablePtr)); getElegantTableName($tablePtr)+" cannot be viewed with this license.")
checkAddErrorIf(Not:C34(isUserAuthorizedToView($tablePtr)); "Sorry, you are not authorized to view this module.")

If (isValidationConfirmed)
	openFormWindow($tablePtr; $formName)
End if 