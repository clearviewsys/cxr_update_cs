[Currencies:6]MinusPctFromMarketBuy:11:=0
[Currencies:6]AddPctToMarketSell:12:=0

[Currencies:6]OffsetMarketBuy:9:=Round:C94([Currencies:6]SpotRateLocal:17-[Currencies:6]OurBuyRateLocal:7; 7)

[Currencies:6]OffsetMarketSell:10:=Round:C94([Currencies:6]OurSellRateLocal:8-[Currencies:6]SpotRateLocal:17; 7)