//%attributes = {}
C_TEXT:C284(vCurrency; vFromCashAccount; vToCashAccount; vFromTransID; vToTransID)
C_LONGINT:C283(vQty)
C_REAL:C285(vDenomination; vTotal)

If ((vQty#0) & (vDenomination>0))
	vTotal:=vQty*vDenomination
	appendToArray(->arrQty; ->vQty)
	appendToArray(->arrDenomination; ->vDenomination)
	appendToArray(->arrTotal; ->vTotal)
	
	vQty:=0
	vDenomination:=0
	vTotal:=0
	GOTO OBJECT:C206(*; "vQty")
Else 
	BEEP:C151
End if 
// 

//QUERY([CashInOuts];[CashInOuts]CashTransactionID=[CashTransactions]CashTransactionID)

//ORDER BY([CashInOuts];[CashInOuts]Denomination;<)

