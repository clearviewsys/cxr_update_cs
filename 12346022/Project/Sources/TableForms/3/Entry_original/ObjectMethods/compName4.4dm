If (Form event code:C388=On Data Change:K2:15)
	pickOccupation(Self:C308)
	If (OK=1)
		[Customers:3]OccupationCode:121:=[Occupations:2]Code:2
		[Customers:3]IndustryCode:122:=[Industries:114]Code:6
	End if 
End if 