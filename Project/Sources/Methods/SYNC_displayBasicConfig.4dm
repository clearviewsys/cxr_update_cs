//%attributes = {"shared":true}

If (isUserAdministrator)
	Sync_BasicConfig(Current process:C322)
Else 
	myAlert_AdminPrivilegeNeeded
End if 