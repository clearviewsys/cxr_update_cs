C_REAL:C285(vSumDebitsLocal; vSumCreditsLocal; vBalanceLocal; vSumFees)

If (Form event code:C388=On Load:K2:1)
	reg_fillRegistersListBox
End if 


If (True:C214)
	getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vBalanceLocal; ->vSumFees)
End if 
