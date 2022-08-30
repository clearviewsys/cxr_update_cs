//%attributes = {}
// display_SR_ExpenseIncomeSummary
// opens the expense or income summary report

If (isUserManager | isUserAllowedToPrintReports)
	openFormWindow(->[Reports:73]; "SR_ExpenseIncomeSummary")
Else 
	myAlert_AccessDenied
End if 