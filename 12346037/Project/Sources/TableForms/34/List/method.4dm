handleListForm
C_REAL:C285(vSumDebits; vSumCredits; vBalance; vSumDebitsLocal; vSumCreditsLocal; vBalanceLocal; vSumDebitsL; vSumCreditsL; vBalanceL)

If (Form event code:C388=On Display Detail:K2:22)
	RELATE ONE:C42([CashAccounts:34]AccountID:1)  // load the currency flags
	getAccountTotals([CashAccounts:34]AccountID:1; ->vSumDebits; ->vSumCredits; ->vBalance; ->vSumDebitsL; ->vSumCreditsL; ->vBalanceL)
	
End if 