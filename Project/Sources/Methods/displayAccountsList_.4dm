//%attributes = {"shared":true}
C_POINTER:C301($tablePtr)
$tablePtr:=->[Accounts:9]

checkInit
checkAddErrorIf(Not:C34(isModuleAuthorized($tablePtr)); getElegantTableName($tablePtr)+" cannot be viewed with this license.")
checkAddErrorIf(Not:C34(isUserAuthorizedToView($tablePtr)); "Sorry, you are not authorized to view this module.")

If (isValidationConfirmed)
	openFormWindow(->[Accounts:9]; "AccountsList")
End if 