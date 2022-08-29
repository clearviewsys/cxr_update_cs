//%attributes = {}
UNLOAD RECORD:C212([Items:39])
pickItems(->[ItemInOuts:40]ItemID:2)
RELATE ONE:C42([ItemInOuts:40]ItemID:2)  // load the item info
If (Records in selection:C76([Items:39])=1)
	[ItemInOuts:40]ItemID:2:=[Items:39]ItemID:1
	[ItemInOuts:40]accountID:13:=[Items:39]AccountID:12
	If ([ItemInOuts:40]isSold:7)  // paid (Sell) 
		[ItemInOuts:40]UnitPrice:9:=[Items:39]SellUnitPrice:7
	Else   // Received (Buy)` 
		[ItemInOuts:40]UnitPrice:9:=[Items:39]BuyUnitPrice:18
	End if 
	[ItemInOuts:40]Currency:11:=[Items:39]Currency:8
	[ItemInOuts:40]FeeLocal:19:=[Items:39]FeeLocal:11
	[ItemInOuts:40]PercentFee:18:=[Items:39]PercentFee:10
	C_LONGINT:C283(cbChargeTax1; cbChargeTax2)
	
	If ([ItemInOuts:40]isSold:7)  // SELL
		cbChargeTax1:=Num:C11([Items:39]isTax1ForSell:16)
		cbChargeTax2:=Num:C11([Items:39]isTax2ForSell:17)
	Else   // BUY
		cbChargeTax1:=Num:C11([Items:39]isTax1forBuy:14)
		cbChargeTax2:=Num:C11([Items:39]isTax2ForBuy:15)
	End if 
Else 
	[ItemInOuts:40]accountID:13:=""
	[ItemInOuts:40]tax1:20:=0
	[ItemInOuts:40]tax2:21:=0
	[ItemInOuts:40]UnitPrice:9:=0
	[ItemInOuts:40]Currency:11:=""
	[ItemInOuts:40]FeeLocal:19:=0
	[ItemInOuts:40]PercentFee:18:=0
End if 