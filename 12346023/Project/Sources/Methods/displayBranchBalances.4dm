//%attributes = {"shared":true}
If ((isUserAllowedToReconcile) | (isUserManager))
	handleProcess(->[Accounts:9]; "displayBranchBalances_"; False:C215)
Else 
	myAlert("User should have reconciliation or management privileges to view this module.")
	
End if 

//displayRemoteAccounts_