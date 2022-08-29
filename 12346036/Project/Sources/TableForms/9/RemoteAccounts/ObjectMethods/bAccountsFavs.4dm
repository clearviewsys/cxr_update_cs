QUERY:C277([Accounts:9]; [Accounts:9]isFlagged:13=True:C214)
If (Records in selection:C76([Accounts:9])>0)
	
	orderByAccounts
	fillAccountsRemoteList(vBranchID)
End if 