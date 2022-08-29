//%attributes = {}
C_REAL:C285(vAmountReceived; vAmountPaid)
C_TEXT:C284(vChequeStatus)

handleListForm
If (Form event code:C388=On Load:K2:1)
	SET FIELD RELATION:C919([Cheques:1]CustomerID:2; Automatic:K51:4; Structure configuration:K51:2)
	SET FIELD RELATION:C919([Cheques:1]RegisterID:6; Automatic:K51:4; Structure configuration:K51:2)  // optimized field relations
End if 

If ((Form event code:C388=On Display Detail:K2:22) | (Form event code:C388=On Printing Detail:K2:18))
	handleChequeDisplayDetail
	colourizeAlternateRows([Cheques:1]isFlagged:24)
	hideObjectsOnTrue(Not:C34([Cheques:1]isFlagged:24); "Flag")
End if 