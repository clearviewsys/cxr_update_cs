//%attributes = {}

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		READ ONLY:C145([Signatures:141])
		QUERY:C277([Signatures:141]; [Signatures:141]InvoiceNumber:2=vInvoiceNumber)
		
		If (Records in selection:C76([Signatures:141])=1)
			Signature:=[Signatures:141]Signature:3
			FORM GOTO PAGE:C247(2)
		Else 
			FORM GOTO PAGE:C247(1)
		End if 
		
End case 
