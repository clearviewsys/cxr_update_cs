handleListForm
If (Form event code:C388=On Display Detail:K2:22)
	RELATE ONE:C42([CashInventory:35]CashAccountID:2)  // load the cash register machine ID
	colorizeNegs(->[CashInventory:35]SystemCount:6)
	
End if 