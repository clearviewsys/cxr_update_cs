If (cbApplyDateRange=0)
	QUERY:C277([WebEWires:149]; [WebEWires:149]WebEwireID:1="@MG@")
Else 
	//handleApplyDateRangeObject (Self)
	//setErrorTrap ("ShowDateRange")
	//executeMethodName ("showDateRange"+Table name(Current form table))
	//endErrorTrap 
	
	selectDateRangeTable(->[WebEWires:149]; ->[WebEWires:149]creationDate:15; vFromDate; vToDate)
	
	QUERY SELECTION:C341([WebEWires:149]; [WebEWires:149]WebEwireID:1="@MG@")
End if 

handleVRecNum(->[WebEWires:149])

orderByWebEWires