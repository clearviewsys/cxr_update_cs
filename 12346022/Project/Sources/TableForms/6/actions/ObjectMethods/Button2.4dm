C_REAL:C285($percent)

$percent:=Num:C11(Request:C163("Increase buy margins by %?"))
USE SET:C118("$currencies_LBSet")

READ WRITE:C146([Currencies:6])
APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]MinusPctFromMarketBuy:11:=[Currencies:6]MinusPctFromMarketBuy:11+$percent)
handleFetchCurrencyRatesButton
READ ONLY:C145([Currencies:6])
