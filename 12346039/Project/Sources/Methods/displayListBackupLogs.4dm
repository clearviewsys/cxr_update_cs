//%attributes = {"shared":true}
If (isUserAdministrator)
	displayLBox(->[BackupLogs:47])
Else 
	myAlert_AdminPrivilegeNeeded
End if 