handleApplyDateRangeObject(Self:C308)

If (cbApplyDateRange=0)
	//allRecords (Current form table)
Else 
	setErrorTrap("ShowDateRange")
	handleApplyDateRangeObject(Self:C308)
	executeMethodName("showDateRange"+Table name:C256(Current form table:C627))
	endErrorTrap
	
End if 
POST OUTSIDE CALL:C329(-1)
