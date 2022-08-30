//%attributes = {"shared":true}
If (isUserAdministrator)
	displayLBox(->[ClientPrefs:26])
Else 
	myAlert_AdminPrivilegeNeeded
End if 
