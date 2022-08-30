//%attributes = {}
handleViewFormMethod(->[ThirdParties:101])

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		If ([ThirdParties:101]IsCompany:2)
			FORM GOTO PAGE:C247(2)
		Else 
			FORM GOTO PAGE:C247(1)
		End if 
		
		
End case 
