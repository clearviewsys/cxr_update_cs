Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([Users:25]isHashed:36)
			OBJECT SET FONT:C164([Users:25]Password:4; "%password")
		End if 
End case 