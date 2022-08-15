//%attributes = {"shared":true}
If (isUserAdministrator)
	displayList(->[FeeStructures:38])
Else 
	myAlert_AdminPrivilegeNeeded
End if 