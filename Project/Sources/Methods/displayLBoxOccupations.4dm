//%attributes = {}
If (isUserAdministrator)
	displayLBox(->[Occupations:2])
Else 
	myAlert_AdminPrivilegeNeeded
End if 