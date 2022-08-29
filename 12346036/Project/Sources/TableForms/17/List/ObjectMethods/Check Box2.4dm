If (cbApplyDateRange=0)
	allRecords(Current form table:C627)
Else 
	handleApplyDateRangeObject(Self:C308)
	selectAccountsInDateRange(vFromDate; vToDate)
	
End if 
POST OUTSIDE CALL:C329(-1)
