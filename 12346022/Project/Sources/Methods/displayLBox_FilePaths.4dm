//%attributes = {"shared":true}
If (isUserAdministrator)
	displayLBox_(->[FilePaths:83])
Else 
	myAlert_AdminPrivilegeNeeded
End if 

