handleDropDownMenu(->[SubAccounts:112]SubAccountID:2; "Sub-Account")

If (Form event code:C388=On Clicked:K2:4)
	If (Self:C308->>1)  // if the till was selected
		Form:C1466.filter.subAccountID:=Self:C308->{Self:C308->}
	Else 
		Form:C1466.filter.subAccountID:=""
	End if 
End if 