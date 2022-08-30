If (Form event code:C388=On Data Change:K2:15)
	pickCountryCode(Self:C308)
	If (OK=1)
		[Customers:3]Citizenship_obs:60:=[Countries:62]CountryName:2
	End if 
End if 