
C_TEXT:C284($enabled)
$enabled:=getKeyValue("signatureEnabled")
If ($enabled=Uppercase:C13("true"))
	QUERY:C277([Signatures:141]; [Signatures:141]InvoiceNumber:2=vInvoiceNumber)
	openFormWindow(->[Invoices:5]; "Signature")
Else 
	myAlert("Signature feature is not enabled. Please enable it using KeyValues table")
End if 

