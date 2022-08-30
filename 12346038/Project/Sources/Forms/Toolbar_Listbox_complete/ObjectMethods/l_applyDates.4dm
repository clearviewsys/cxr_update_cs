handleApplyDateRangeObject(Self:C308)

If (cbApplyDateRange=0)
	//allRecords (Current form table)
Else 
	handleApplyDateRangeObject(Self:C308)
	setErrorTrap("ShowDateRange")
	executeMethodName("showDateRange"+Table name:C256(Current form table:C627))
	endErrorTrap
End if 
POST OUTSIDE CALL:C329(-1)
