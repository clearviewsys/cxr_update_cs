//%attributes = {"shared":true}
C_POINTER:C301($1)
C_POINTER:C301($tablePtr)
$tablePtr:=->[eWires:13]

checkInit
checkAddErrorIf(Not:C34(isModuleAuthorized($tablePtr)); getElegantTableName($tablePtr)+" cannot be viewed with this license.")
checkAddErrorIf(Not:C34(isUserAuthorizedToView($tablePtr)); "Sorry, you are not authorized to view this module.")

If (isValidationConfirmed)
	openFormWindow(->[eWires:13]; "AgentPOList")
End if 