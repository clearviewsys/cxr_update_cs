//%attributes = {"shared":true}
If (isUserAdministrator)
	EXPORT DATA:C666("")
Else 
	myAlert_AdminPrivilegeNeeded
End if 