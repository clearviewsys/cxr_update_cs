If (Form event code:C388=On Clicked:K2:4)
	pickCountryCode(->[Customers:3]CitizenshipCountryCode:22; True:C214)
	If (OK=1)
		[Customers:3]Citizenship_obs:60:=[Countries:62]CountryName:2
	End if 
End if 