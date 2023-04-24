//%attributes = {}
//displayLBox_Sync_Queue

If (isUserAdministrator)
	displayLBox_(->[Sync_Queue:30])
Else 
	myAlert_AdminPrivilegeNeeded
End if 