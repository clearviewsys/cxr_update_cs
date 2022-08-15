//%attributes = {}
// handleSaveCashTrasaction (doSaveTransaction:boolean)
C_BOOLEAN:C305($1)

checkInit
validateAccountPickedInInvoice
validateCashTransactions
validateRatesSensibility([CashTransactions:36]Currency:4; Not:C34([CashTransactions:36]isPaid:2); [CashTransactions:36]ourRate:15; [Currencies:6]OurBuyRateLocal:7; [Currencies:6]SpotRateLocal:17; [Currencies:6]OurSellRateLocal:8)
If (isValidationConfirmed)
	createRegisterOfCashTrans
	clearInvoiceEnterableVars
	If ($1)
		//validatetransaction  // disabled by: Barclay Berry (2/24/13) per Tiran
	End if 
Else 
	REJECT:C38
End if 

