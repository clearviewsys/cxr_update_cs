//%attributes = {}
If (isUserAdministrator)
	displayLBox_(->[TestRun:100])
Else 
	myAlert_AdminPrivilegeNeeded
End if 