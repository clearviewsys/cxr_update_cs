//%attributes = {}
If ([Currencies:6]doIgnoreMarkups:46=False:C215)
	[Currencies:6]OurBuyRateLocal:7:=calcOurBuyRate([Currencies:6]SpotRateLocal:17; [Currencies:6]OffsetMarketBuy:9; [Currencies:6]MinusPctFromMarketBuy:11)
	[Currencies:6]OurSellRateLocal:8:=calcOurSellRate([Currencies:6]SpotRateLocal:17; [Currencies:6]OffsetMarketSell:10; [Currencies:6]AddPctToMarketSell:12)
	
	
	If ([Currencies:6]maxBuyLocal:15>0)
		[Currencies:6]OurBuyRateLocal:7:=calcMin([Currencies:6]OurBuyRateLocal:7; [Currencies:6]maxBuyLocal:15)
	End if 
	
	If ([Currencies:6]minSellLocal:16>0)
		[Currencies:6]OurSellRateLocal:8:=calcMax([Currencies:6]OurSellRateLocal:8; [Currencies:6]minSellLocal:16)
	End if 
End if 
// Set the rounding of the rates

roundThisCurrencyRateFields

