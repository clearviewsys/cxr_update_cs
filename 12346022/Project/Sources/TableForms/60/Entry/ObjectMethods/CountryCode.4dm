If (Form event code:C388=On Data Change:K2:15)
	[Cities:60]CountryCode:4:=Uppercase:C13(Self:C308->)
	RELATE ONE:C42([Cities:60]CountryCode:4)
	
End if 