C_REAL:C285(vSumOffBalances)

If (Form event code:C388=On Load:K2:1)
	fillAdjustmentArrays(<>baseCurrency)
	
	EDIT ITEM:C870(arrAdjustedBalances; 1)
End if 

If (Form event code:C388=On Data Change:K2:15)
	
End if 

vSumOffBalances:=Sum:C1(arrOffBalances)
