//%attributes = {}
RELATE ONE:C42([Invoices:5]CustomerID:2)
[Invoices:5]AutoComments:24:=makeCommentsInvoice

If ([Invoices:5]invoiceDate:44=nullDate)
	[Invoices:5]invoiceDate:44:=[Invoices:5]CreationDate:13
End if 