//%attributes = {}
READ ONLY:C145([Registers:10])

// map all the currencies that had a transaction between two dates

QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2=Current date:C33)

RELATE ONE SELECTION:C349([Registers:10]; [Currencies:6])
orderByCurrencies
