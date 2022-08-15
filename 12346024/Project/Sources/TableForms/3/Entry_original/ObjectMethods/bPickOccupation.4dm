If (Form event code:C388=On Clicked:K2:4)
	pickOccupation(->[Customers:3]OccupationCode:121; True:C214)
	If (Ok=1)
		[Customers:3]Occupation:21:=[Occupations:2]Occupation:3
	End if 
End if 