Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If ([WebUsers:14]isLocked:10)
			[WebUsers:14]incorrectPasswordCount:4:=4
		Else 
			[WebUsers:14]incorrectPasswordCount:4:=0
		End if 
		
		
End case 
