//%attributes = {"shared":true}
If (isUserAdministrator)
	displayLBox_(->[Users:25])
Else 
	myAlert_AdminPrivilegeNeeded
End if 
