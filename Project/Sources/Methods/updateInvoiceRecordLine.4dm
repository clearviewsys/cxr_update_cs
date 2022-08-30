//%attributes = {}
Case of 
	: ([Invoices:5]TransactionType:12="Buy")
		[Invoices:5]fromAmount:25:=[Invoices:5]CurrencyBought:4
		[Invoices:5]toAmount:26:=[Invoices:5]AmountPaidCAD:7
		[Invoices:5]ExchangeRate:21:=([Invoices:5]toAmount:26+[Invoices:5]feeLocal:6)/([Invoices:5]fromAmount:25)
		
	: ([Invoices:5]TransactionType:12="Sell")
		[Invoices:5]fromAmount:25:=[Invoices:5]AmountReceivedCAD:9
		[Invoices:5]toAmount:26:=[Invoices:5]TotalCurrencySold:11
		[Invoices:5]ExchangeRate:21:=[Invoices:5]toAmount:26/([Invoices:5]fromAmount:25-[Invoices:5]feeLocal:6)
		
	: ([Invoices:5]TransactionType:12="Cross")  // CROSS
		[Invoices:5]fromAmount:25:=[Invoices:5]CurrencyBought:4
		[Invoices:5]toAmount:26:=[Invoices:5]TotalCurrencySold:11
		[Invoices:5]ExchangeRate:21:=(calcSafeDivide([Invoices:5]feeLocal:6; [Invoices:5]PolicyRateSell:10)+[Invoices:5]toAmount:26)/[Invoices:5]fromAmount:25
	: ([Invoices:5]TransactionType:12="Charge")  // charge
		[Invoices:5]fromAmount:25:=[Invoices:5]AmountReceivedCAD:9
		[Invoices:5]toAmount:26:=[Invoices:5]AmountPaidCAD:7
		[Invoices:5]ExchangeRate:21:=1
End case 