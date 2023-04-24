//%attributes = {"shared":true}

If (isUserAdministrator)
	displayLBox_(->[ClientPrefs:26])
Else 
	myAlert_AdminPrivilegeNeeded
End if 

