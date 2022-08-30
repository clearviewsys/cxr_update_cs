//%attributes = {"shared":true}
If (isUserAdministrator)
	openFormWindow(->[FeeRules:59]; "FeeRules")
Else 
	myAlert_AdminPrivilegeNeeded
End if 