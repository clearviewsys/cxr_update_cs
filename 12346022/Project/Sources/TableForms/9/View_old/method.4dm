handleViewForm
If (Form event code:C388=On Load:K2:1)
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Clicked:K2:4))
	RELATE ONE:C42([Accounts:9]MainAccountID:2)  // display the information about the parent account
	
	//relateMany (->[Registers];->[Registers]AccountID;->[Accounts]AccountID)  ` load all the registers for this account
	//orderByRegisters 
	//C_REAL(vSumDebits;vSumCredits;vBalance;vSumDebitsLocal;vSumCreditsLocal;vBalanceLocal)
	//getRegisterSums (->vSumDebitsLocal;->vSumCreditsLocal;->vBalanceLocal;->vSumDebits;->vSumCredits;->vBalance)
	
	
	//handleTab_CurrenciesViewRegisters
	// called from handleTabCurrenciesView
	showObjectOnTrue([Accounts:9]isRestrictedToManagers:14; "isRestricted")
	If (isUserAllowedToViewThisAccount)
		//handleAccountsViewRegisters 
		
		
		
		SELECTION TO ARRAY:C260([Registers:10]RegisterID:1; acc_arrRegisterIDs; [Registers:10]isValidated:35; acc_arrIsValidated; [Registers:10]RegisterDate:2; acc_arrDates; [Registers:10]CustomerID:5; acc_arrCustomers; [Registers:10]Debit:8; acc_arrIns; [Registers:10]Credit:7; acc_arrOuts; [Registers:10]Currency:19; acc_arrCurrencies; [Registers:10]OurRate:25; acc_arrRates; [Registers:10]feeLocal:29; acc_arrFees; [Registers:10]DebitLocal:23; acc_arrDebits; [Registers:10]CreditLocal:24; acc_arrCredits; [Registers:10]InvoiceNumber:10; acc_arrInvoiceIDs; [Registers:10]isTransfer:3; acc_arrIsTransfer)
	End if 
End if 
