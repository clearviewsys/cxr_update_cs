//%attributes = {}


C_REAL:C285(vFromAmount; vToAmount)
C_DATE:C307(vInvoiceDate)
C_TIME:C306(vInvoiceTime)
C_TEXT:C284(vFromCurrency; vToCurrency; vInvoiceNumber; vCustomerID)

vInvoiceDate:=[Invoices:5]invoiceDate:44
vInvoiceTime:=[Invoices:5]CreationTime:14

vInvoiceNumber:=[Invoices:5]InvoiceID:1
vCustomerID:=[Invoices:5]CustomerID:2

vFromAmount:=[Invoices:5]fromAmount:25
vToAmount:=[Invoices:5]toAmount:26
vFromCurrency:=[Invoices:5]fromCurrency:3
vToCurrency:=[Invoices:5]toCurrency:8

RELATE ONE:C42([Invoices:5]CustomerID:2)

//setFlagPicture (->vFromFlag;[Invoices]fromCurrency)
//setFlagPicture (->vToFlag;[Invoices]toCurrency)
