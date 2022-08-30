//%attributes = {"shared":true}


// sync monitor should be visible by managers too
If (isUserManager)
	Sync_Monitor(Current process:C322)  //;$MenuRefNew)
Else 
	myAlert_ManagerPrivilegeNeeded
End if 
