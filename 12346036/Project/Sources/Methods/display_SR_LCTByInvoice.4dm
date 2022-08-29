//%attributes = {}
// displayReport_aggregateCashTransactionsByInvoice
// opens the aggregiate cash transactions by invoice form

If (isUserManager | isUserAllowedToPrintReports)
	openFormWindow(->[Reports:73]; "SR_LCTByInvoice")
Else 
	myAlert_AccessDenied
End if 