If (Form event code:C388=On Clicked:K2:4)
	If ([Customers:3]CountryOfResidenceCode:114="")
		[Customers:3]CountryOfResidenceCode:114:=getCountryCode([Customers:3]CountryOfResidence_obs:61)
	End if 
End if 