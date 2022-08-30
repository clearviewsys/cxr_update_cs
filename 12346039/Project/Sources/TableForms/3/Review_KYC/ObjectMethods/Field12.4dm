If (Form event code:C388=On Clicked:K2:4)
	If ([Customers:3]CitizenshipCountryCode:22="")
		[Customers:3]CitizenshipCountryCode:22:=getCountryCode([Customers:3]Citizenship_obs:60)
	End if 
End if 