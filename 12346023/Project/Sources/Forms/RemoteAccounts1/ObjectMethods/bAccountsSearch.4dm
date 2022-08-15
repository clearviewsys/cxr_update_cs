C_TEXT:C284($vSearchString)
$vSearchString:=Request:C163("Please enter a search string:")
//searchAccounts ($vSearchString)
QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$vSearchString)
If (Records in selection:C76([Accounts:9])>0)
	orderByAccounts
	fillAccountsRemoteList(vBranchID)
End if 
