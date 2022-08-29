If (Form event code:C388=On Data Change:K2:15)
	C_TEXT:C284($branchID)
	$branchID:=Form:C1466.Rule.ifBranchID
	pickBranchID(->$branchID)
	Form:C1466.Rule.ifBranchID:=$branchID
End if 