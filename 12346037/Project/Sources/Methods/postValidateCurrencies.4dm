//%attributes = {}
//If (([Currencies]OpeningAvgRate=0) & ([Currencies]isDisplayOnly=False))  ` if it is a tradable currency 
//CONFIRM("Do you want to set the 'Initial Rate' to the average market rate "+String([Currencies]SpotRateLocal;"|Rates");"Yes";"No")
//If (OK=1)
//[Currencies]OpeningAvgRate:=[Currencies]SpotRateLocal
//[Currencies]OpeningDate:=Current date
//  `[Currencies]OpeningBalance_:=0
//End if 
//End if 
C_LONGINT:C283($j)
C_TEXT:C284($cashAccountID)
If ([Currencies:6]hasCashAccount:23)  // if this account requires, create the Cash Account
	createCashAccount([Currencies:6]CurrencyCode:1)
	READ ONLY:C145([CashRegisters:33])
	ALL RECORDS:C47([CashRegisters:33])
	For ($j; 1; Records in selection:C76([CashRegisters:33]))
		LOAD RECORD:C52([CashRegisters:33])
		If ([CashRegisters:33]autoCreateCashAccounts:9)
			createCashAccount([Currencies:6]CurrencyCode:1; [CashRegisters:33]CashRegisterID:1)
			$cashAccountID:=makeCashAccountID([Currencies:6]CurrencyCode:1; [CashRegisters:33]CashRegisterID:1)
			assignCashAccountToCashRegister($cashAccountID; [CashRegisters:33]CashRegisterID:1)
		End if 
		NEXT RECORD:C51([CashRegisters:33])
	End for 
End if 

If ([Currencies:6]hasChequeAccount:24)  // if this account requires, create the Cheque Account
	createChequeReceivable([Currencies:6]CurrencyCode:1)
	createChequePayable([Currencies:6]CurrencyCode:1)
	//createBankAccount ([Currencies]CurrencyCode)
End if 
