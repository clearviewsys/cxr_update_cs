[Currencies:6]MinusPctFromMarketBuy:11:=Round:C94(100*(1-([Currencies:6]OurBuyRateLocal:7/[Currencies:6]SpotRateLocal:17)); 5)
[Currencies:6]AddPctToMarketSell:12:=Round:C94(([Currencies:6]OurSellRateLocal:8/[Currencies:6]SpotRateLocal:17-1)*100; 5)

[Currencies:6]OffsetMarketBuy:9:=0

[Currencies:6]OffsetMarketSell:10:=0