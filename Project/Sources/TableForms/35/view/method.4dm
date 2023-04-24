handleViewForm

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	RELATE MANY:C262([CashInventory:35]CashInventoryID:1)  // load cash in and outs
	ORDER BY:C49([CashInOuts:32]; [CashInOuts:32]CashTransactionID:1)
	C_REAL:C285(vSumQtyIn; vSumQtyOut; vSumTotalIn; vSumTotalOut)
	vSumQtyIn:=Sum:C1([CashInOuts:32]QtyIN:8)
	vSumQtyOut:=Sum:C1([CashInOuts:32]QtyOut:9)
	vSumTotalIn:=Sum:C1([CashInOuts:32]TotalIn:10)
	vSumTotalOut:=Sum:C1([CashInOuts:32]TotalOut:11)
End if 
