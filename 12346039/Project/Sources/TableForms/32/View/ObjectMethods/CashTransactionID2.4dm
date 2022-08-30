If (Form event code:C388=On Clicked:K2:4)
	
	RELATE ONE:C42([CashTransactions:36]InvoiceID:7)
	displayCurrentRecord(->[Invoices:5])
	
End if 