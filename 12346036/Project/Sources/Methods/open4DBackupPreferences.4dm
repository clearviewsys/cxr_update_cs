//%attributes = {"shared":true}
If (isUserSuperAdmin)
	OPEN SETTINGS WINDOW:C903("/Backup/Backup")
Else 
	myalert_SuperAminNeeded
End if 