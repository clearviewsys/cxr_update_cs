HandleEntryFormMethod

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Is new record:C668([Cities:60]))
			UNLOAD RECORD:C212([States:61])
			UNLOAD RECORD:C212([Countries:62])
		Else 
			RELATE ONE:C42([Cities:60]StateCode:2)
			RELATE ONE:C42([States:61]CountryCode:2)
		End if 
End case 