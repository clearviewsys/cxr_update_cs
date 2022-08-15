Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Self:C308->)
			myConfirm("This will remove the current token. Ok to continue?")
			
			If (OK=1)
				[WebUsers:14]confirmationToken:6:=""
			Else 
				Self:C308->:=0
			End if 
			
		End if 
		
	Else 
		
		
End case 