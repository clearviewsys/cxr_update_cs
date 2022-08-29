//%attributes = {"shared":true}
If (isUserAdministrator)
	IMPORT DATA:C665("")
Else 
	myAlert_AdminPrivilegeNeeded
End if 