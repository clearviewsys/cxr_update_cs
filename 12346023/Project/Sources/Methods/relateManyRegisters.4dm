//%attributes = {}
//relates all related registers in an invoice


QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=[Invoices:5]InvoiceID:1)  // to speed up
//RELATE MANY([Invoices]InvoiceNumber)  ` load all the registers again for display in invoice
ORDER BY:C49([Registers:10]; [Registers:10]RegisterID:1)