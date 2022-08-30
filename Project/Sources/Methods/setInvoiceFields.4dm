//%attributes = {}
// setInvoiceFields (...
// 1: customerID
// 2: fromAmount
// 3: fromCurr
// 4: toAmount
// 5: toCurr
// 6: fee
// 7: isFeePaidSeparately
C_TEXT:C284($eWireID; $CustomerID; $fromCurrency; $toCurrency; $CAD)
C_REAL:C285($fee; $exchangeRate; $sellRate; $buyRate; $fromAmount; $toAmount)

[Invoices:5]eWireID:23:=$eWireID
[Invoices:5]CustomerID:2:=$CustomerID
[Invoices:5]fromCurrency:3:=$fromCurrency
[Invoices:5]toCurrency:8:=$toCurrency
[Invoices:5]feeLocal:6:=$fee
[Invoices:5]ExchangeRate:21:=$exchangeRate



$CAD:=<>baseCurrency


Case of 
		
	: (($fromCurrency#$CAD) & ($toCurrency=$CAD))  // buy
		[Invoices:5]AmountReceivedCAD:9:=0
		[Invoices:5]CurrencyBought:4:=$fromAmount
		[Invoices:5]TotalCurrencySold:11:=0
		[Invoices:5]AmountPaidCAD:7:=$toAmount
		
		[Invoices:5]PolicyRateBuy:5:=$buyRate
		[Invoices:5]PolicyRateSell:10:=$sellRate
		[Invoices:5]ExchangeRate:21:=$exchangeRate
		
		[Invoices:5]TransactionType:12:="Buy"
		
	: (($fromCurrency=$CAD) & ($toCurrency#$CAD))  // SELL
		
		[Invoices:5]AmountReceivedCAD:9:=$fromAmount
		[Invoices:5]CurrencyBought:4:=0
		[Invoices:5]TotalCurrencySold:11:=$toAmount
		[Invoices:5]AmountPaidCAD:7:=0
		
		[Invoices:5]TransactionType:12:="Sell"
		
	: (($fromCurrency#$CAD) & ($toCurrency#$CAD))  // CROSS
		[Invoices:5]AmountReceivedCAD:9:=0
		[Invoices:5]CurrencyBought:4:=$fromAmount
		[Invoices:5]TotalCurrencySold:11:=$toAmount
		[Invoices:5]AmountPaidCAD:7:=0
		
		[Invoices:5]TransactionType:12:="Cross"
		
	: (($fromCurrency=$CAD) & ($toCurrency=$CAD))  // CROSS
		[Invoices:5]AmountReceivedCAD:9:=$fromAmount
		[Invoices:5]CurrencyBought:4:=0
		[Invoices:5]TotalCurrencySold:11:=0
		[Invoices:5]AmountPaidCAD:7:=$toAmount
		
		[Invoices:5]TransactionType:12:="Charge"
End case 