Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([Users:25]isHashed:36)
			OBJECT SET FONT:C164([Users:25]Password:4; "%password")
		Else 
			OBJECT SET FONT:C164([Users:25]Password:4; "Calibri")
		End if 
	: (Form event code:C388=On Data Change:K2:15)
		[Users:25]isHashed:36:=False:C215
	: (Form event code:C388=On Before Keystroke:K2:6)
		OBJECT SET FONT:C164([Users:25]Password:4; "Calibri")
End case 