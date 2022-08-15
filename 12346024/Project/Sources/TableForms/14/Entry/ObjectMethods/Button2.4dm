

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (isUserManager)
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (OBJECT Get font:C1069([WebUsers:14]Password:2)="%password")
			OBJECT SET FONT:C164([WebUsers:14]Password:2; "Arial")
		Else 
			OBJECT SET FONT:C164([WebUsers:14]Password:2; "%password")
		End if 
		
	Else 
		
End case 