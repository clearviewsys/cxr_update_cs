
QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[WebEWires:149]paymentInfo:35.invoiceID)
If (Records in selection:C76([Invoices:5])=1)
	displayCurrentRecord(->[Invoices:5])
End if 
