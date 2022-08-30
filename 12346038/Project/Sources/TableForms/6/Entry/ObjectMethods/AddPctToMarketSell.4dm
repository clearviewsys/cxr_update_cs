// calcOurSellRate(MarketSell;offsetSell;pctSell) -> real

[Currencies:6]OurSellRateLocal:8:=calcOurSellRate([Currencies:6]SpotRateLocal:17; [Currencies:6]OffsetMarketSell:10; [Currencies:6]AddPctToMarketSell:12)
[Currencies:6]OurSellRateInverse:26:=1/[Currencies:6]OurSellRateLocal:8
