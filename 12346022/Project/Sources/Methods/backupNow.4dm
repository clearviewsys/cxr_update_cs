//%attributes = {"shared":true}

If (isUserAdministrator)
	myConfirm("All transactions will be suspended during backup."; "Backup Now"; "Cancel")
	If (OK=1)
		BACKUP:C887
	End if 
Else 
	myAlert_AdminPrivilegeNeeded
End if 