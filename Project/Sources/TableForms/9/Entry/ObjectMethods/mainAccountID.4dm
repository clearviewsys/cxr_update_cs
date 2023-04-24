pickMainAccounts(Self:C308)
RELATE ONE:C42([Accounts:9]MainAccountID:2)
[Accounts:9]AccountType:5:=[MainAccounts:28]AccountType:4

If (([MainAccounts:28]MainAccountID:1=c_Cash) | ([MainAccounts:28]MainAccountID:1=c_ForeignCurrencies))
	[Accounts:9]isCashAccount:3:=True:C214
Else 
	[Accounts:9]isCashAccount:3:=False:C215
End if 

If ([MainAccounts:28]MainAccountID:1=c_Banks)
	[Accounts:9]isBankAccount:7:=True:C214
Else 
	[Accounts:9]isBankAccount:7:=False:C215
End if 