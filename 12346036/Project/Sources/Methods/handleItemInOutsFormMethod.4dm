//%attributes = {}
// handleItemInOutsFormMethod (sell:bool)

C_BOOLEAN:C305($isSell; $1)
C_LONGINT:C283(cbChargeTax1; cbChargeTax2)
$isSell:=$1

If (onNewRecordEvent)
	UNLOAD RECORD:C212([Items:39])  // unload the previously loaded item
	
	[ItemInOuts:40]ItemInOutID:1:=makeItemInOutsID
	setItemInOutsFieldsToInvVars($isSell; [ItemInOuts:40]ItemInOutID:1)
	
End if 

If (Form event code:C388=On Load:K2:1)  // both for modification and new record
	GOTO OBJECT:C206([ItemInOuts:40]ItemID:2)
	If ([ItemInOuts:40]isSold:7)  // SELL
		OBJECT SET TITLE:C194(*; "l_unit_price"; "Sell Unit Price")
		OBJECT SET TITLE:C194(*; "l_qty"; "Sell Qty.")
	Else   // BUY
		OBJECT SET TITLE:C194(*; "l_unit_Price"; "Purchase Price per unit")
		OBJECT SET TITLE:C194(*; "l_qty"; "Buy Qty.")
		
	End if 
End if 

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Double Clicked:K2:5))
	RELATE ONE:C42([ItemInOuts:40]accountID:13)  // maybe necessary to load the account name
	[ItemInOuts:40]AmountBeforeTax:10:=roundToBase(([ItemInOuts:40]Qty:8*[ItemInOuts:40]UnitPrice:9)*(1-([ItemInOuts:40]discount:33/100)))
	
	[ItemInOuts:40]tax1:20:=[ItemInOuts:40]AmountBeforeTax:10*<>tax1*cbChargeTax1
	[ItemInOuts:40]tax2:21:=[ItemInOuts:40]AmountBeforeTax:10*<>tax2*cbChargeTax2
	
	roundThisToBase(->[ItemInOuts:40]tax1:20)
	roundThisToBase(->[ItemInOuts:40]tax2:21)
	If ([Items:39]isTaxInclusive:25)
		[ItemInOuts:40]Amount:22:=roundToBase([ItemInOuts:40]AmountBeforeTax:10)
	Else 
		[ItemInOuts:40]Amount:22:=roundToBase([ItemInOuts:40]AmountBeforeTax:10+[ItemInOuts:40]tax1:20+[ItemInOuts:40]tax2:21)
	End if 
	//[ItemInOuts]amountLocal:=[ItemInOuts]Amount
	
	
End if 

If ([ItemInOuts:40]isSold:7)  // when selling a Item
	//If ([Items]isSellPriceFixed)
	//OBJECT SET ENTERABLE([ItemInOuts]UnitPrice;False)
	//Else 
	//OBJECT SET ENTERABLE([ItemInOuts]UnitPrice;True)
	//End if 
Else   // when buying a Item
	//If ([Items]isBuyPriceFixed)
	//OBJECT SET ENTERABLE([ItemInOuts]UnitPrice;False)
	//Else 
	//OBJECT SET ENTERABLE([ItemInOuts]UnitPrice;True)
	//End if 
End if 

handleCloseBox