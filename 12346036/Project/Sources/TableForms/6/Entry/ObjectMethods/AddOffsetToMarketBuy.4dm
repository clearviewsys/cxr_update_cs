// calcOurBuyRate(MarketBuy;offsetBuy;pctBuy) -> real

[Currencies:6]OurBuyRateLocal:7:=calcOurBuyRate([Currencies:6]SpotRateLocal:17; [Currencies:6]OffsetMarketBuy:9; [Currencies:6]MinusPctFromMarketBuy:11)
[Currencies:6]OurBuyRateInverse:25:=1/[Currencies:6]OurBuyRateLocal:7
