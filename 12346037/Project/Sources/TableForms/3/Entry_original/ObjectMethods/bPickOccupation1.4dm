If (Form event code:C388=On Clicked:K2:4)
	pickIndustryCode(->[Customers:3]IndustryCode:122; True:C214)
	RELATE ONE:C42([Customers:3]IndustryCode:122)
End if 