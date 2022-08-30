//%attributes = {}
If (isUserManager)
	QUERY:C277([Accounts:9]; [Accounts:9]isHidden:21=False:C215)
Else 
	QUERY:C277([Accounts:9]; [Accounts:9]isHidden:21=False:C215; *)
	QUERY:C277([Accounts:9]; [Accounts:9]isRestrictedToManagers:14=False:C215)
End if 
orderByAccounts