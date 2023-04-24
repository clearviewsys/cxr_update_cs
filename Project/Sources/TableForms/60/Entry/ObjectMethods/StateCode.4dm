If (Form event code:C388=On Data Change:K2:15)
	[Cities:60]StateCode:2:=Uppercase:C13([Cities:60]StateCode:2)
	RELATE ONE:C42([Cities:60]StateCode:2)  // load the state
	If (Records in selection:C76([States:61])>0)  // if a state is found
		RELATE ONE:C42([States:61]CountryCode:2)  // load the corresponding country
		[Cities:60]CountryCode:4:=[States:61]CountryCode:2
	End if 
	
End if 