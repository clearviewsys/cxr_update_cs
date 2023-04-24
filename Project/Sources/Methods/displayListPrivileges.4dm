//%attributes = {"shared":true}
If (isUserSuperAdmin)
	displayLBox(->[Privileges:24])
Else 
	myalert_SuperAminNeeded
End if 