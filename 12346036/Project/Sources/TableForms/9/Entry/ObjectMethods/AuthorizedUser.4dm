If ([Accounts:9]isForeignAccount:15)
	//pickWebUsers (Self)` why this was here? maybe because we wanted at some point allow web users to access their related accounts.
	
	pickAgents(Self:C308)  // why this was not working?
	If (OK=1)
		[Accounts:9]isInternational:38:=True:C214
		[Accounts:9]CountryCode:39:=[Agents:22]CountryCode:21
	End if 
Else 
	UNLOAD RECORD:C212([Agents:22])
	//RELATE ONE([Accounts]AuthorizedUser)
End if 