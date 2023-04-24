If (cbApplyDateRange=0)
	QUERY:C277([WebEWires:149]; [WebEWires:149]status:16>=30)
Else 
	selectDateRangeTable(->[WebEWires:149]; ->[WebEWires:149]creationDate:15; vFromDate; vToDate)
	QUERY SELECTION:C341([WebEWires:149]; [WebEWires:149]status:16>=30)
End if 

orderByWebEWires