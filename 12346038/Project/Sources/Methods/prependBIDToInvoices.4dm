//%attributes = {}
//QUERY([Invoices];[Invoices]InvoiceNumber="INV@")
//updateTableUsingMethod (->[Invoices];"prependBranchIDToInvoiceRec";False)

prependBIDToTable(->[Invoices:5]; ->[Invoices:5]InvoiceID:1)

