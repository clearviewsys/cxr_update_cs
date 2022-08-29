If (Form event code:C388=On Clicked:K2:4)
	OpenEmailURL([Customers:3]Email:17+"?subject="+"Invoice "+[Invoices:5]InvoiceID:1+"&body="+makeEmailBodyFromInvoice)
End if 