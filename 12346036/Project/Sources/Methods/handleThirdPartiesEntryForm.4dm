//%attributes = {}
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		If (Not:C34(Undefined:C82(vInvoiceNumber)))
			[ThirdParties:101]InvoiceID:30:=vInvoiceNumber
		End if 
		
		If ([ThirdParties:101]IsCompany:2)
			FORM GOTO PAGE:C247(2)
		Else 
			FORM GOTO PAGE:C247(1)
		End if 
		
		
End case 
