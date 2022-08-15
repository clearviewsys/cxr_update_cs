//%attributes = {}
// handleQuickCashButton
// this method is called from a button in the Invoice.entry form

C_BOOLEAN:C305($isPaid)
C_BOOLEAN:C305(isInternalInvoice)
C_BOOLEAN:C305(isOK)  // this is my own OK varaible (boolean) which remembers if cancel is pressed or not


IsInternalInvoice:=[Invoices:5]isTransfer:42

checkInit
validateAddLineInInvoice

If (isValidationConfirmed)
	If (getVecCurrencyString="")
		setVecCurrency(<>baseCurrency)
	End if 
	
	If (vAmount=0)  // this line simplifies the entry by automatically filling the pay off value when the amount is 0
		handlePayOffButton
	End if 
	
	If (vReceivedOrPaid=getReceivedOrPayString(2))
		$isPaid:=True:C214
	Else 
		$isPaid:=False:C215
	End if 
	
	C_TEXT:C284($vPaymentMethod)
	$vPaymentMethod:=vecPaymentMethod{vecPaymentMethod}
	
	Case of 
			// if paying by cash, and currency requires denoms, and amount >=0 and reached limit
		: (($vPaymentMethod=c_Cash) & ($isPaid=True:C214) & ([Currencies:6]doRequestDenoms:53) & (vAmount>=[Currencies:6]RequestDenomOnPayGT:52) & ([Currencies:6]RequestDenomOnPayGT:52>=0))
			handleAddLineButton
			
		: (($vPaymentMethod=c_Cash) & ($isPaid=False:C215) & ([Currencies:6]doRequestDenoms:53) & (vAmount>=[Currencies:6]RequestDenomOnReceiveGT:51) & ([Currencies:6]RequestDenomOnReceiveGT:51>=0))
			handleAddLineButton
			
		: (($vPaymentMethod=c_Cash) & ($isPaid=True:C214) & ([Currencies:6]doPreventShortSelling:54))
			handleAddLineButton
			
		: ($vPaymentMethod=c_Cash)
			checkInit
			checkAddErrorIf(vAmount=0; "Amount cannot be zero.")
			
			checkAddErrorIf((vAmountLocal><>oneIDLimit) & (vCustomerID=getWalkInCustomerID) & <>doFINTRACchecks; "For this transaction customer must have a file.")
			If ((vAmountLocal>=<>overrideLimit) & (<>overrideLimit>0))  // if the override limit is positive and limit is exceeded then ask for password
				checkIfPasswordMatches(<>overridePassword; "This transaction requires the manager's authorization"; 2)
			End if 
			
			If (isValidationConfirmed)
				checkInit
				CREATE RECORD:C68([CashTransactions:36])
				setCashTransFieldsToInvoiceVars($isPaid; makeCashTransactionsID)
				selectCashAccountsForUser(vCurrency)
				FIRST RECORD:C50([Accounts:9])
				[CashTransactions:36]CashAccountID:9:=[Accounts:9]AccountID:1
				// VERIFY if the cash account is valid__________________________________________________________ added in ver. 3.426
				//validateRatesSensibility ([CashTransactions]Currency;Not([CashTransactions]isPaid);[CashTransactions]ourRate;[Currencies]OurBuyRateLocal;[Currencies]SpotRateLocal;[Currencies]OurSellRateLocal)
				checkIfAccountIDExists(->[CashTransactions:36]CashAccountID:9; "Cash Account")
				checkifAccountisOfCurrency([Accounts:9]AccountID:1; [CashTransactions:36]Currency:4)
				checkAddErrorIf(vRate=0; "Rate Cannot be 0")
				
				If (isValidationConfirmed)
					createRegisterOfCashTrans
					SAVE RECORD:C53([CashTransactions:36])
					
					clearInvoiceEnterableVars
				End if 
			End if 
		Else 
			handleAddLineButton
	End case 
	
	If (isOK)
		vecPaymentMethod{0}:=c_Cash
		vecPaymentMethod:=0
	End if 
	
	relateManyRegistersForInvoice
	GOTO OBJECT:C206(*; "vReceivedPaid")
	
	
	
End if 