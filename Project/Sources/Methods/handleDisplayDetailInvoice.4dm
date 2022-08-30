//%attributes = {}
// handleDisplayDetailInvoice ( isCalledFromListform:bool)
// if called from list form use a (true)
// if called from the customers invoice detail use a false

C_BOOLEAN:C305($1)

C_REAL:C285(vFromAmount; vToAmount; vFromBalance; vToBalance)
If (Form event code:C388=On Load:K2:1)
	// we need to establish the relations here
	If ($1=True:C214)
		SET FIELD RELATION:C919([Invoices:5]CustomerID:2; Automatic:K51:4; Structure configuration:K51:2)
	End if 
End if 



If (Form event code:C388=On Display Detail:K2:22)
	C_LONGINT:C283(cbShowOffBalances)
	
	If (cbShowOffBalances=1)
		RELATE MANY:C262([Invoices:5]InvoiceID:1)  // select all related registers
		calcInvoiceVars(->vFromAmount; ->vToAmount; ->vFromBalance; ->vToBalance)
		colorizeOnTrue(->[Invoices:5]TransactionType:12; Not:C34([Invoices:5]isSuspicious:30))
	Else 
		vFromBalance:=0
		vToBalance:=0
	End if 
	hideObjectsOnTrue(([Invoices:5]eWireID:23=""); "eWire@")
	hideObjectsOnTrue(([Invoices:5]fromCurrency:3=<>baseCurrency); "localBalanceFrom")
	hideObjectsOnTrue(([Invoices:5]toCurrency:8=<>baseCurrency); "localBalanceTo")
	//colourizeLineBG ("backstripe")
End if 
