//%attributes = {}
C_REAL:C285(vSumDebits; vSumCredits; vSumBalance)
C_REAL:C285(vSumDebitsLocal; vSumCreditsLocal; vSumBalanceLocal)

C_TEXT:C284(vCommonCurrency)
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // select all the registers linked to accounts 

If (isSelectionHomogeneous(->[Accounts:9]; ->[Accounts:9]Currency:6; ->vCommonCurrency))
	getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vSumBalanceLocal; ->vSumDebits; ->vSumCredits; ->vSumBalance)
Else 
	vSumDebits:=0
	vSumCredits:=0
	vSumBalance:=0
	vCommonCurrency:=""
	getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vSumBalanceLocal)
End if 