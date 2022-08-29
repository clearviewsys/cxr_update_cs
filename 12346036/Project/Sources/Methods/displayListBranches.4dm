//%attributes = {"shared":true}
If (isUserAdministrator)
	displayList(->[Branches:70])
Else 
	myAlert_AdminPrivilegeNeeded
End if 