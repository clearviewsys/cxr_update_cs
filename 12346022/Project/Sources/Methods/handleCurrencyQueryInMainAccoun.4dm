//%attributes = {}
C_TEXT:C284(vCurrencyQuery)

If (vCurrencyQuery#"")
	CREATE SET:C116([Accounts:9]; "$accounts")
	QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=vCurrencyQuery; *)
	QUERY:C277([Accounts:9];  & ; [Accounts:9]MainAccountID:2=[MainAccounts:28]MainAccountID:1)
Else 
	relateMany(->[Accounts:9]; ->[Accounts:9]MainAccountID:2; ->[MainAccounts:28]MainAccountID:1)
	orderByAccounts
End if 