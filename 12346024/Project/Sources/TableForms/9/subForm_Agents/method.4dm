C_REAL:C285(vSumDebits; vSumCredits; vBalance; vSumDebitsLocal; vSumCreditsLocal; vBalanceLocal)

If (Form event code:C388=On Display Detail:K2:22)
	getAccountTotals([Accounts:9]AccountID:1; ->vSumDebits; ->vSumCredits; ->vBalance; ->vSumDebitsLocal; ->vSumCreditsLocal; ->vBalanceLocal)
End if 