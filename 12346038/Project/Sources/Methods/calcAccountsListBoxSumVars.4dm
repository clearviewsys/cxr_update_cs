//%attributes = {}
C_REAL:C285(vSumarrIns; vSumarrOuts; vSumDebits; vSumCredits; vSumMarketValues; vBalanceDebit; vBalanceCredit)
C_REAL:C285(vInventoryOnHand)

//vSumDebits:=vecSum (->acc_arrDebits)
//vSumCredits:=vecSum (->acc_arrCredits)
//vSumMarketValues:=vecSum (->acc_arrMarketValues)

If (vecIsHomogeneous(->acc_arrCurrencies))
	vInventoryOnHand:=Sum:C1(acc_arrBalances)
	vSumarrIns:=Sum:C1(acc_arrIns)
	vSumarrOuts:=Sum:C1(acc_arrOuts)
Else 
	vInventoryOnHand:=0
	vSumarrIns:=0
	vSumarrOuts:=0
	
End if 



//If (vSumDebits>vSumCredits)
//vBalanceDebit:=vSumDebits-vSumCredits
//vBalanceCredit:=0
//Else 
//vBalanceCredit:=vSumCredits-vSumDebits
//vBalanceDebit:=0
//End if 