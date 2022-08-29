//%attributes = {}

// ******** THESE TWO LINES ARE NOW OBSOLETE 
// *********** BACKWARD COMPATIBILITY IS LOST VERSION 128 (APR 15, 2004)

//vFromAmount:=[Invoices]AmountReceivedCAD+[Invoices]CurrencyBought  ` one of these value is zero
//vToAmount:=[Invoices]TotalCurrencySold+[Invoices]TotalBoughtAmountCAD  ` one of these values is zero

C_REAL:C285(vFromAmount; vToAmount)
C_DATE:C307(vInvoiceDate)
C_TIME:C306(vInvoiceTime)
C_TEXT:C284(vFromCurrency; vToCurrency; vInvoiceNumber; vCustomerID)

[Invoices:5]invoiceDate:44:=vInvoiceDate
[Invoices:5]CreationTime:14:=vInvoiceTime

[Invoices:5]InvoiceID:1:=vInvoiceNumber
[Invoices:5]CustomerID:2:=vCustomerID

[Invoices:5]fromAmount:25:=vFromAmount
[Invoices:5]toAmount:26:=vToAmount
[Invoices:5]fromCurrency:3:=vFromCurrency
[Invoices:5]toCurrency:8:=vToCurrency

[Invoices:5]fromAmountLC:38:=vSumDebitsLocal
[Invoices:5]toAmountLC:39:=vSumCreditsLocal