If (Form event code:C388=On Clicked:K2:4)
	pickCountryCode(->[Customers:3]CountryOfResidenceCode:114; True:C214)
	If (OK=1)
		[Customers:3]CountryOfResidence_obs:61:=[Countries:62]CountryName:2
	End if 
End if 