//%attributes = {}
If (Not:C34(isUserAdministrator))
	checkAddError("Sorry, this function is restricted to administrators only.")
End if 