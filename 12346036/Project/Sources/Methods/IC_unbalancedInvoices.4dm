//%attributes = {}
// this integrity check checks that invoices be square in both sides

If (True:C214)
	integrityChecksRun(JSON Stringify:C1217(New object:C1471("unbalancedInvoices"; "True")))
Else 
	integrityCheck(->[Invoices:5]; Current method name:C684; "invoice balances are square"; ->[Invoices:5]invoiceDate:44)
End if 