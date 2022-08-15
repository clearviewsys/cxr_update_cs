// form method of registers/subform_Bankaccounts

If ((Form event code:C388=On Display Detail:K2:22) | (Form event code:C388=On Printing Detail:K2:18))
	RELATE ONE:C42([Registers:10]CustomerID:5)
	colourizeAlternateRows([Registers:10]isFlagged:11)
End if 

If (Form event code:C388=On Double Clicked:K2:5)
	handledoubleclickevent
End if 