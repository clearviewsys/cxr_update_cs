//%attributes = {}
If (isUserAdministrator)
	displayLBox_(->[SanctionLists:113])
Else 
	myAlert_AdminPrivilegeNeeded
End if 
