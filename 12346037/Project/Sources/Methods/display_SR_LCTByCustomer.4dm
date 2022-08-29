//%attributes = {}
// displayReport_LCTByCustomer
// opens the aggregiate cash transactions by customer report

If (isUserManager | isUserAllowedToPrintReports)
	openFormWindow(->[Reports:73]; "SR_LCTAggrCustomerDaily")
Else 
	myAlert_AccessDenied
End if 