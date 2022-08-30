//%attributes = {}

CONFIRM:C162("Are you sure you want to delete the backup log?")

If (OK=1)
	Begin SQL
		DELETE FROM [BackupLogs];
	End SQL
End if 
