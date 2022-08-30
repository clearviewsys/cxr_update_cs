C_REAL:C285(vServiceFee; vForeignFee; vPercentFee; vFromAmount; vToAmount)
C_TEXT:C284(vCustomerID; vFromCurrency; vToCurrency)

handleCBfeeStructure(->vForeignFee; ->vPercentFee; ->vFeeLocal; ->vCustomerID; ->vFromAmount; ->vFromCurrency; ->vToAmount; ->vToCurrency)

If (Form event code:C388#On Load:K2:1)  // on changing the selection
	If (Record number:C243([Invoices:5])<0)  // it's a new record*********
		
		handleVecCurrencyMethod
		
	Else   // an invoice is being modified********************
		
	End if 
End if 