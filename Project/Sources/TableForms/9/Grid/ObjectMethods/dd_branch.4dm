handleDropDownMenu(->[Branches:70]BranchID:1; "🏛 Branch")


If (Form event code:C388=On Clicked:K2:4)
	If (Self:C308->>1)  // if the till was selected
		Form:C1466.filter.branchID:=Self:C308->{Self:C308->}
	Else 
		Form:C1466.filter.branchID:=""
	End if 
End if 