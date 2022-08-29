//%attributes = {}
// createInvoice (customerID; fromAmount; fromCur; toAmount;toCur;feeCAD;

// PRE: CUSTOMERID must be loaded

// RECORD IS STILL LOADED


// create an invoice record


READ WRITE:C146([Invoices:5])
CREATE RECORD:C68([Invoices:5])
pickCustomer(->[eWires:13]CustomerID:15)
vCustomerID:=[eWires:13]CustomerID:15
vFromAmount:=[eWires:13]FromAmount:13
vToAmount:=[eWires:13]ToAmount:14
vFromCurrency:=[eWires:13]FromCurrency:11
vToCurrency:=[eWires:13]Currency:12
vExchangeRate:=vToAmount/vFromAmount
vInvoiceDate:=Current date:C33
vInvoiceNumber:=makeInvoiceID

setInvoiceFieldstoVars

SAVE RECORD:C53([Invoices:5])
UNLOAD RECORD:C212([Invoices:5])
READ ONLY:C145([Invoices:5])