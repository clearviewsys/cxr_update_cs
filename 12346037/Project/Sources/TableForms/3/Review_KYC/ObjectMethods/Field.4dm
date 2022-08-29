If (Form event code:C388=On Clicked:K2:4)
	If ([Customers:3]CountryOfBirthCode:18="")
		[Customers:3]CountryOfBirthCode:18:=getCountryCode([Customers:3]Nationality:91)
	End if 
End if 