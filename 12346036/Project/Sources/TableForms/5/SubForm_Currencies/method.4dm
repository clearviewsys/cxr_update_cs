If (Form event code:C388=On Load:K2:1)
	C_REAL:C285(vFromAmount; vToAmount)
	
	
End if 

If (Form event code:C388=On Display Detail:K2:22)
	//C_INTEGER($transactionType)
	//If ([Currencies]CurrencyCode#◊baseCurrency)
	//$transactionType:=getInvoiceTransactionTypeEnum ([Invoices]TransactionType)
	//Else 
	//$transactionType:=0
	//End if 
	//Case of 
	//: ($transactionType=1)  ` Buy
	//vFromAmount:=[Invoices]CurrencyBought
	//  `vToAmount:=[Invoices]TotalBoughtAmountCAD
	//vToAmount:=0
	//
	//: ($transactionType=2)  ` Sell
	//  `vFromAmount:=[Invoices]AmountReceivedCAD
	//vToAmount:=[Invoices]TotalCurrencySold
	//vFromAmount:=0
	//
	//: ($transactionType=3)  ` Cross
	//If ([Invoices]fromCurrency=[Currencies]CurrencyCode)
	//vFromAmount:=[Invoices]CurrencyBought
	//vToAmount:=0
	//Else 
	//vFromAmount:=0
	//vToAmount:=[Invoices]TotalCurrencySold
	//End if 
	//: ($transactionType=0)
	//vFromAmount:=0
	//vToAmount:=0
	//End case 
	vFromAmount:=0
	vToAmount:=0
	If ([Invoices:5]fromCurrency:3=[Currencies:6]CurrencyCode:1)
		vFromAmount:=[Invoices:5]fromAmount:25
	End if 
	If ([Invoices:5]toCurrency:8=[Currencies:6]CurrencyCode:1)
		vToAmount:=[Invoices:5]toAmount:26
	End if 
End if 