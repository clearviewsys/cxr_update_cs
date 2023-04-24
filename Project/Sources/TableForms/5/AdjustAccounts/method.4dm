C_REAL:C285(vSumOffBalances; vSumOffBalancesLC)
C_LONGINT:C283(rbOpening; rbClosing; rbAdjusting)

If (Form event code:C388=On Load:K2:1)
	rbOpening:=0
	rbClosing:=0
	rbAdjusting:=1
	fillAdjustmentArrays2
	
	EDIT ITEM:C870(arrAdjustedBalances; 1)
End if 

If (Form event code:C388=On Data Change:K2:15)
	
End if 

//vSumOffBalances:=Sum(arrOffBalances)
//vSumOffBalancesLC:=Sum(arrOffBalancesLC)
