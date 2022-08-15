If (isCheckBoxSwitchedOn(Self:C308))
	[Customers:3]AML_ignoreKYC:35:=True:C214
	[Customers:3]AML_IgnoreRepeatTransWarn:108:=True:C214
	[Customers:3]AML_isWhitelisted:131:=True:C214
	[Customers:3]AML_WhitelistExpiryDate:130:=newDate(1; 1; 2050)
	[Customers:3]AML_WhitelistNotes:126:="Customer is an insider"
Else   // switched off
	resetOldValue(->[Customers:3]AML_ignoreKYC:35)
	resetOldValue(->[Customers:3]AML_IgnoreRepeatTransWarn:108)
	resetOldValue(->[Customers:3]AML_isWhitelisted:131)
	resetOldValue(->[Customers:3]AML_WhitelistExpiryDate:130)
	resetOldValue(->[Customers:3]AML_WhitelistNotes:126)
	
End if 

