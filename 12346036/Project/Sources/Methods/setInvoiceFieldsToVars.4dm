//%attributes = {}

// ******** THESE TWO LINES ARE NOW OBSOLETE 
// *********** BACKWARD COMPATIBILITY IS LOST VERSION 128 (APR 15, 2004)

//vFromAmount:=[Invoices]AmountReceivedCAD+[Invoices]CurrencyBought  ` one of these value is zero
//vToAmount:=[Invoices]TotalCurrencySold+[Invoices]TotalBoughtAmountCAD  ` one of these values is zero

C_REAL:C285(vFromAmount; vToAmount; vExchangeRate; vExchangeRateAve; vServiceFee; vForeignFee; vPercentFee; vFromOurBuy; vToOurSell; vRate1; vRate2)
C_DATE:C307(vInvoiceDate)
C_TEXT:C284(vFromCurrency; vToCurrency; vInvoiceNumber)


[Invoices:5]invoiceDate:44:=vInvoiceDate
[Invoices:5]InvoiceID:1:=vInvoiceNumber
[Invoices:5]CustomerID:2:=vCustomerID

[Invoices:5]fromAmount:25:=vFromAmount
[Invoices:5]toAmount:26:=vToAmount
[Invoices:5]fromCurrency:3:=vFromCurrency
[Invoices:5]toCurrency:8:=vToCurrency

[Invoices:5]ExchangeRate:21:=vExchangeRate
[Invoices:5]PolicyRateBuy:5:=vFromOurBuy
[Invoices:5]PolicyRateSell:10:=vToOurSell
[Invoices:5]BuyRate:36:=vRate1
[Invoices:5]SellRate:37:=vRate2

[Invoices:5]feeLocal:6:=vServiceFee
[Invoices:5]ForeignFee:27:=vForeignFee
[Invoices:5]PercentFee:28:=vPercentFee

[Invoices:5]ThirdPartyisInvolved:22:=numToBoolean(cbFeePaidSeparately)
[Invoices:5]ThirdPartyisInvolved:22:=False:C215
//
//[Invoices]SpotRateBuy:=vFromMarketAvg // modified by TB in vers 3.615
//[Invoices]SpotRateSell:=vToMarketAvg // commented by TAB in version 3.615

Case of 
	: (([Invoices:5]fromCurrency:3#<>baseCurrency) & ([Invoices:5]toCurrency:8=<>baseCurrency))  // buy
		[Invoices:5]CurrencyBought:4:=vFromAmount
		[Invoices:5]AmountPaidCAD:7:=vToAmount
		[Invoices:5]TransactionType:12:="Buy"
		
	: (([Invoices:5]fromCurrency:3=<>baseCurrency) & ([Invoices:5]toCurrency:8#<>baseCurrency))  // sell
		[Invoices:5]AmountReceivedCAD:9:=vFromAmount
		[Invoices:5]TotalCurrencySold:11:=vToAmount
		[Invoices:5]TransactionType:12:="Sell"
		
	: (([Invoices:5]fromCurrency:3#<>baseCurrency) & ([Invoices:5]toCurrency:8#<>baseCurrency))  // cross
		[Invoices:5]CurrencyBought:4:=vFromAmount
		[Invoices:5]TotalCurrencySold:11:=vToAmount
		[Invoices:5]TransactionType:12:="Cross"
		
	: (([Invoices:5]fromCurrency:3=<>baseCurrency) & ([Invoices:5]toCurrency:8=<>baseCurrency))  // charge
		[Invoices:5]AmountReceivedCAD:9:=vFromAmount
		[Invoices:5]AmountPaidCAD:7:=vToAmount
		[Invoices:5]TransactionType:12:="Charge"
		
	: (([Invoices:5]fromCurrency:3#<>baseCurrency) & ([Invoices:5]fromCurrency:3=[Invoices:5]toCurrency:8))  // charge
		[Invoices:5]CurrencyBought:4:=vFromAmount
		[Invoices:5]TotalCurrencySold:11:=vToAmount
		[Invoices:5]TransactionType:12:="Charge"
		
End case 
