C_TEXT:C284(vFromAccount; vToAccount)
If ((vFromAccount#"") | (vToAccount#""))
	swapStrings(->vFromAccount; ->vToAccount)
	swapStrings(->vFromSubAccountID; ->vToSubAccountID)
End if 