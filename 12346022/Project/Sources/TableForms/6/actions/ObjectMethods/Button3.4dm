C_REAL:C285($percent)

$percent:=Num:C11(Request:C163("Increase buy margins by %?"))
READ WRITE:C146([Currencies:6])
USE SET:C118("$currencies_LBSet")

APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]AddPctToMarketSell:12:=[Currencies:6]AddPctToMarketSell:12+$percent)

READ ONLY:C145([Currencies:6])
