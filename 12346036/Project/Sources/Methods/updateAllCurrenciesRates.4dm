//%attributes = {}
QUERY:C277([Currencies:6]; [Currencies:6]AutoUpdateOurRates:21=True:C214)
updateTableUsingMethod(->[Currencies:6]; "updateThisCurrencyRate"; False:C215)

READ ONLY:C145([Currencies:6])
REDUCE SELECTION:C351([Currencies:6]; 0)