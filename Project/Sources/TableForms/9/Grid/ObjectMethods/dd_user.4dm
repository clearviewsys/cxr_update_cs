handleDropDownMenu(->[Users:25]UserName:3; "User")

If (Form event code:C388=On Load:K2:1)
	APPEND TO ARRAY:C911(Self:C308->; "Designer")
	APPEND TO ARRAY:C911(Self:C308->; "Administrator")
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (Self:C308->>1)  // if the till was selected
		Form:C1466.filter.userID:=Self:C308->{Self:C308->}
	Else 
		Form:C1466.filter.userID:=""
	End if 
End if 