populateDD_Branches

If (Form event code:C388=On Load:K2:1)
	Form:C1466.branchID:=""
End if 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	Form:C1466.branchID:=Self:C308->{Self:C308->}
End if 