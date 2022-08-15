If (Form event code:C388=On Clicked:K2:4)
	If (([Customers:3]CountryCode:113="") & ([Customers:3]Country_obs:11#""))
		[Customers:3]CountryCode:113:=getCountryCode([Customers:3]Country_obs:11)
	End if 
End if 