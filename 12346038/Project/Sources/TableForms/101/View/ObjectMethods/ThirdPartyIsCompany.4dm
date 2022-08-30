If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	
	If ([ThirdParties:101]IsCompany:2)
		FORM GOTO PAGE:C247(2)
	Else 
		FORM GOTO PAGE:C247(1)
	End if 
	
	
End if 