If (Form event code:C388=On Data Change:K2:15)
	checkInit
	checkIfUserIsAdmin
	checkAddWarning("Make sure you only use a safe command in this field. It's a good idea to test the command making the spelling is correct.")
	
	If (isValidationConfirmed)
		//
		
	Else 
		[AMLRules:74]executeMethod:60:=Old:C35([AMLRules:74]executeMethod:60)
	End if 
	
End if 
