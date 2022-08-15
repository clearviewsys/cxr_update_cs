Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([ClientPrefs:26]ClientName:1="")
			[ClientPrefs:26]ClientName:1:=getCurrentMachineName
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		[ClientPrefs:26]ClientName:1:=getCurrentMachineName
		
End case 

