//%attributes = {}
C_REAL:C285(vSumDebitsLocal; vSumCreditsLocal; vBalanceLocal)


relateMany(->[Accounts:9]; ->[Accounts:9]MainAccountID:2; ->[MainAccounts:28]MainAccountID:1)
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // then select the related registers
If (cbApplyDateRange=1)
	selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; vFromDate; vToDate)
End if 
getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vBalanceLocal)
