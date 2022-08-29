//%attributes = {"shared":true}
If (isUserAdministrator)
	CHECK LOG FILE:C799
Else 
	myAlert_AdminPrivilegeNeeded
End if 