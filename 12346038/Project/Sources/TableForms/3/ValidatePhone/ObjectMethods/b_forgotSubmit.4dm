C_POINTER:C301($p_enteredCode)
C_TEXT:C284($enteredCode)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$p_enteredCode:=OBJECT Get pointer:C1124(Object named:K67:5; "CodeEntryField")
		$enteredCode:=$p_enteredCode->
		
		If ($enteredCode=Form:C1466.resetCode)
			[Customers:3]isCellPhoneValidated:143:=True:C214
			myAlert("Cell phone is validated")
		Else 
			myAlert("Entered Code does not match."+Char:C90(Carriage return:K15:38)+\
				"Please double check your reset code."+Char:C90(Carriage return:K15:38)+\
				"If the error persists, please contact your system administrator.")
			REJECT:C38
		End if 
End case 

