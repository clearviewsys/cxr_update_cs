If (Form event code:C388=On Data Change:K2:15)
	pickCountryCode(Self:C308)
	If (OK=1)
		[eWires:13]fromCountry:9:=[Countries:62]CountryName:2
		selectLinksByCustIDnCountry(Self:C308->)
		UNLOAD RECORD:C212([Links:17])
	End if 
End if 