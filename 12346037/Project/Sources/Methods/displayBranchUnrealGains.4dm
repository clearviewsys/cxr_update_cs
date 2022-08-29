//%attributes = {"shared":true}
If (isUserManager)
	handleProcess(->[Accounts:9]; "displayBranchUnrealGains_"; False:C215)
Else 
	myAlert("User should have reconciliation or management privileges to view this module.")
	
End if 

//displayRemoteAccounts_
