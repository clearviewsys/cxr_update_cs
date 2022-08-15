C_REAL:C285(vSpreadInPct; vSpreadInPoints; vSpreadinPointsInv)

HandleEntryFormMethod(->[Currencies:6])


If (Form event code:C388=On Load:K2:1)
	OBJECT SET VISIBLE:C603(*; "updateOval@"; False:C215)
	If ([Currencies:6]toISO4217:32="")  // default value
		[Currencies:6]toISO4217:32:=<>baseCurrency
	End if 
	GOTO OBJECT:C206([Currencies:6]ISO4217:31)
End if 

If (onNewRecordEvent)
	[Currencies:6]hasCashAccount:23:=True:C214
	[Currencies:6]AddPctToMarketSell:12:=<>defaultSellCommission
	[Currencies:6]MinusPctFromMarketBuy:11:=<>defaultBuyCommission
	[Currencies:6]AutoUpdateOurRates:21:=True:C214
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Clicked:K2:4))
	//C_REAL(vOpeningBalance)
	//relateMany (->[Accounts];->[Accounts]Currency;->[Currencies]CurrencyCode)
	//vOpeningBalance:=Sum([Accounts]OpeningDebit)-Sum([Accounts]OpeningCredit)
	QUERY:C277([Denominations:31]; [Denominations:31]Currency:2=[Currencies:6]ISO4217:31)
	orderByDenominations
End if 

If (Form event code:C388=On Data Change:K2:15)
	
	If ([Currencies:6]toISO4217:32#<>baseCurrency)
		[Currencies:6]isDisplayOnly:33:=True:C214
	End if 
End if 

If ([Currencies:6]hasCashAccount:23)
	OBJECT SET ENTERABLE:C238([Currencies:6]weBuyCoins:47; True:C214)
	OBJECT SET ENTERABLE:C238([Currencies:6]weSellCoins:48; True:C214)
Else 
	OBJECT SET ENTERABLE:C238([Currencies:6]weBuyCoins:47; False:C215)
	OBJECT SET ENTERABLE:C238([Currencies:6]weSellCoins:48; False:C215)
	[Currencies:6]weBuyCoins:47:=False:C215
	[Currencies:6]weSellCoins:48:=False:C215
End if 

vSpreadInPct:=calcPctChange([Currencies:6]OurBuyRateLocal:7; [Currencies:6]OurSellRateLocal:8)
vSpreadinPoints:=[Currencies:6]OurSellRateLocal:8-[Currencies:6]OurBuyRateLocal:7
vSpreadinPointsInv:=[Currencies:6]OurBuyRateInverse:25-[Currencies:6]OurSellRateInverse:26

//enableButtonIf (Modified record(Current form table->);"bUpdate")
setVisibleIff(Not:C34([Currencies:6]doIgnoreMarkups:46); "link_@")
