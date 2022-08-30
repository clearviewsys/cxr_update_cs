If (vCurrency#"")
	pickAccountsOfCurrency(->vAccountID; vCurrency)
Else 
	pickAccounts(->vAccountID; "allRecordsAccounts")
	
End if 