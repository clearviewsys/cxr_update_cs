If (Form event code:C388=On Clicked:K2:4)
	pickCountryCode(->[Customers:3]CountryOfBirthCode:18; True:C214)
	If (OK=1)
		[Customers:3]Nationality:91:=[Countries:62]CountryName:2
	End if 
End if 