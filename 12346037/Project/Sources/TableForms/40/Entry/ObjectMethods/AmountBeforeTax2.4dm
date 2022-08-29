If (Form event code:C388=On Data Change:K2:15)
	If ([ItemInOuts:40]UnitPrice:9=0)
		If ([ItemInOuts:40]isSold:7)  // sell
			[ItemInOuts:40]UnitPrice:9:=[Items:39]SellUnitPrice:7
		Else   // buy
			[ItemInOuts:40]UnitPrice:9:=[Items:39]BuyUnitPrice:18
		End if 
	End if 
End if 
applyFocusRect