If (([Customers:3]CountryCode:113="") & ([Customers:3]Country_obs:11#""))
	[Customers:3]CountryCode:113:=getCountryCode([Customers:3]Country_obs:11)
End if 

If ([Customers:3]Country_obs:11="")
	pickCountryCode(->[Customers:3]CountryCode:113)
	If (OK=1)
		[Customers:3]Country_obs:11:=[Countries:62]CountryName:2
	End if 
End if 