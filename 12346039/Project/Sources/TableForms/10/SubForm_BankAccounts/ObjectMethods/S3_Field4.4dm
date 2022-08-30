If (Form event code:C388=On Data Change:K2:15)
	[Registers:10]validatedByUserID:37:=getApplicationUser
	If ([Registers:10]validationCode:36#"")
		[Registers:10]isValidated:35:=True:C214
	End if 
End if 
