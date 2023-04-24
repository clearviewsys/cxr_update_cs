//%attributes = {}
// this integrity check checks that invoices be square in both sides

If (True:C214)
	If (cbApplyDateRange=1)  // (vFromDate#!00-00-00!) & (vToDate#!00-00-00!)
		integrityChecksRun(JSON Stringify:C1217(New object:C1471("unbalancedInvoices"; "True"; "startDate"; vFromDate; "endDate"; vToDate)))
	Else 
		integrityChecksRun(JSON Stringify:C1217(New object:C1471("unbalancedInvoices"; "True"; "startDate"; Add to date:C393(Current date:C33; -10; 0; 0); "endDate"; Current date:C33)))
	End if 
	
Else 
	integrityCheck(->[Invoices:5]; Current method name:C684; "invoice balances are square"; ->[Invoices:5]invoiceDate:44)
End if 