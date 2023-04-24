//%attributes = {}
// createAllCashAccounts
// this method creates one record in the table accounts for each cash register for each currency (that accepts cash)
READ ONLY:C145([Currencies:6])
ALL RECORDS:C47([Currencies:6])
C_TEXT:C284($symbol)
C_LONGINT:C283($i; $j; $progress)

READ ONLY:C145([Accounts:9])

READ ONLY:C145([CashRegisters:33])
ALL RECORDS:C47([CashRegisters:33])
FIRST RECORD:C50([CashRegisters:33])
$progress:=launchProgressBar("Creating cash accounts...")
For ($j; 1; Records in selection:C76([CashRegisters:33]))
	FIRST RECORD:C50([Currencies:6])
	For ($i; 1; Records in selection:C76([Currencies:6]))
		setProgressBarTitle($progress; "Processing: "+[Currencies:6]Name:2)
		$symbol:=makeCashAccountID([Currencies:6]CurrencyCode:1; [CashRegisters:33]CashRegisterID:1)
		QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$symbol)
		If (Records in selection:C76([Accounts:9])=0)  // if there's no such account then create it
			If ([Currencies:6]hasCashAccount:23 & [CashRegisters:33]autoCreateCashAccounts:9)
				createCashAccount([Currencies:6]CurrencyCode:1; [CashRegisters:33]CashRegisterID:1; [CashRegisters:33]isAdminOnly:10)
			End if 
		End if 
		// unload record([currencies])` this may be a good idea to add (the unload record), haven't tested yet
		NEXT RECORD:C51([Currencies:6])
	End for 
	setProgressBarTitle($progress; "Processing: "+[CashRegisters:33]CashRegisterName:7)
	NEXT RECORD:C51([CashRegisters:33])
End for 
HIDE PROCESS:C324($progress)