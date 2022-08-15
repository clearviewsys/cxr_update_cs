//%attributes = {}
// createAllChequeAccounts

C_TEXT:C284($symbol)
C_LONGINT:C283($i)

ALL RECORDS:C47([Currencies:6])

For ($i; 1; Records in selection:C76([Currencies:6]))
	$symbol:=makeChequeAccountID([Currencies:6]CurrencyCode:1)
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$symbol)
	If (Records in selection:C76([Accounts:9])=0)  // if there's no such account then create it
		
		If ([Currencies:6]hasChequeAccount:24)
			createChequeReceivable([Currencies:6]CurrencyCode:1)
		End if 
	End if 
	NEXT RECORD:C51([Currencies:6])
End for 