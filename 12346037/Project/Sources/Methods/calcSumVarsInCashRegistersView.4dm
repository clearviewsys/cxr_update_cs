//%attributes = {}
//calcSumsVarsInCashRegistersView
// this method is called from buttons inside the CASH REGISTERS View form


C_REAL:C285(vSumSystemCounts; vSumTotals; vSumActualCounts; vSumActualTotals; vSumShortCounts; vSumShortTotals)
C_TEXT:C284(vCurrency)

If (Records in selection:C76([CashAccounts:34])=1)
	vSumSystemCounts:=Sum:C1([CashInventory:35]SystemCount:6)
	vSumSystemTotals:=Sum:C1([CashInventory:35]SystemTotal:7)
	
	vSumActualCounts:=Sum:C1([CashInventory:35]ActualCount:8)
	vSumActualTotals:=Sum:C1([CashInventory:35]ActualTotal:9)
	
	vSumShortCounts:=Sum:C1([CashInventory:35]ShortCount:10)
	vSumShortTotals:=Sum:C1([CashInventory:35]ShortValue:11)
	vCurrency:=[CashInventory:35]Currency:4
Else 
	vSumSystemCounts:=0
	vSumSystemTotals:=0
	
	vSumActualCounts:=0
	vSumActualTotals:=0
	
	vSumShortCounts:=0
	vSumShortTotals:=0
	vCurrency:=""
End if 