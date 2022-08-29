//%attributes = {}
//handleInvoiceSignatureButton
// this handler method is called from the 'Signature' button in the invoice.entry form

C_TEXT:C284($enabled)
$enabled:=getKeyValue("signatureEnabled")
Case of 
	: ($enabled="true")
		QUERY:C277([Signatures:141]; [Signatures:141]InvoiceNumber:2=vInvoiceNumber)
		openFormWindow(->[Invoices:5]; "Signature")
	: ($enabled="topaz")
		// getKeyValueDescription
		If (signTopaz(->[Invoices:5]signature:101))
		Else 
			myAlert("Something went wrong reading the signature file!")
		End if 
		
	Else 
		myAlert("Signature feature is not enabled. Please enable it using KeyValue signatureEnabled")
End case 


