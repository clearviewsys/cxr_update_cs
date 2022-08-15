//%attributes = {}
C_REAL:C285(vBuyAmount; vSellAmount; vTax; vQtyIn; vQtyOut)
RELATE ONE:C42([ItemInOuts:40]ItemID:2)  // load the item names
vTax:=[ItemInOuts:40]tax1:20+[ItemInOuts:40]tax2:21
If ([ItemInOuts:40]isSold:7)
	vSellAmount:=[ItemInOuts:40]Amount:22
	vBuyAmount:=0
	vQtyOut:=[ItemInOuts:40]Qty:8
	vQtyIn:=0
Else 
	vBuyAmount:=[ItemInOuts:40]Amount:22
	vSellAmount:=0
	vQtyOut:=0
	vQtyIn:=[ItemInOuts:40]Qty:8
End if 