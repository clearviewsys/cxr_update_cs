If (Form event code:C388=On Clicked:K2:4)
	pickCountryCode(->[WireTemplates:42]BankCountryCode:35; True:C214)
	If (OK=1)
		[WireTemplates:42]BankCountry:12:=[Countries:62]CountryName:2
	End if 
End if 