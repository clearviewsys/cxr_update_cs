//%attributes = {}
// handleButtonSaveSignature

READ WRITE:C146([Signatures:141])

QUERY:C277([Signatures:141]; [Signatures:141]InvoiceNumber:2=vInvoiceNumber)
If (Records in selection:C76([Signatures:141])=0)
	CreateSignature
Else 
	UpdateSignature
End if 

UNLOAD RECORD:C212([Signatures:141])


