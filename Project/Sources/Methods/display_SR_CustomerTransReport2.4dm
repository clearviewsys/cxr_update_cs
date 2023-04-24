//%attributes = {}
// display_SR_CustomerTransYearlyReport
// opens the customer yearly transaction statistics report

If (isUserManager | isUserAllowedToPrintReports)
	openFormWindow(->[Reports:73]; "SR_CustomerTransYearlyStats")
Else 
	myAlert_AccessDenied
End if 