//%attributes = {}
C_REAL:C285(vSumSystemTotals; vSumActualTotals; vSumShortTotals)

vSumSystemTotals:=Sum:C1([CashInventory:35]SystemTotal:7)
vSumActualTotals:=Sum:C1([CashInventory:35]ActualTotal:9)
vSumShortTotals:=Sum:C1([CashInventory:35]ShortValue:11)