//%attributes = {}
READ ONLY:C145([Registers:10])

// map all the currencies that had a transaction between two dates
requestDateRange
If (OK=1)
	QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
	
	RELATE ONE SELECTION:C349([Registers:10]; [Currencies:6])
	orderByCurrencies
End if 