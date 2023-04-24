//%attributes = {}
RELATE MANY SELECTION:C340([Accounts:9]MainAccountID:2)  // first select all related accounts
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // then select the related registers

C_REAL:C285(vTotalSumDebitsLocal; vTotalSumCreditsLocal; vTotalBalanceLocal)
If (cbApplyDateRange=1)
	selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; vFromDate; vToDate; True:C214)
End if 
getRegisterSums(->vTotalSumDebitsLocal; ->vTotalSumCreditsLocal; ->vTotalBalanceLocal)
