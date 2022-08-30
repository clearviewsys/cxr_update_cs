//%attributes = {"shared":true}

C_POINTER:C301($1)  // Jan 16, 2012 19:13:47 -- I.Barclay Berry 
If (isUserManager)
	openFormWindow(->[Accounts:9]; "RemoteAccounts")
	//DIALOG([Accounts];"RemoteAccounts")
Else 
	myAlert_ManagerPrivilegeNeeded
End if 