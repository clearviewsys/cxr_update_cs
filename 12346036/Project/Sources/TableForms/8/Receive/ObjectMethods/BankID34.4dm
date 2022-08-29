If (Form event code:C388=On Data Change:K2:15)
	pickCountryCode(Self:C308)
	If (OK=1)
		[Wires:8]OriginatingBankCountry:46:=[Countries:62]CountryName:2
	End if 
End if 