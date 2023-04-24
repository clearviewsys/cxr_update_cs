//relateOne (->[Invoices];->[RegistersAuditTrail]orig_InvoiceNumber;->[Invoices]InvoiceNumber)
QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[RegistersAuditTrail:88]orig_InvoiceNumber:12)
If (Records in selection:C76([Invoices:5])>0)
	displayCurrentRecord(->[Invoices:5])
Else 
	myAlert("Invoice "+[RegistersAuditTrail:88]orig_InvoiceNumber:12+" no found.")
End if 
