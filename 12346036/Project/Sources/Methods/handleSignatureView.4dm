//%attributes = {}

If (getKeyValue("signatureEnabled")="true")
	READ ONLY:C145([Signatures:141])
	QUERY:C277([Signatures:141]; [Signatures:141]InvoiceNumber:2=[Invoices:5]InvoiceID:1)
	openFormWindow(->[Signatures:141]; "View")
	UNLOAD RECORD:C212([Signatures:141])
Else 
	myAlert("Signature feature is not enabled. Please enable it using 'signatureEnabled' KeyValues table")
End if 
