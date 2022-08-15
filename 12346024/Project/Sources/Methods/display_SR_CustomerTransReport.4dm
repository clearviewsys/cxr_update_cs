//%attributes = {}
// display_SR_CustomerTransReport
// opens the customer transaction statistics report

If (isUserManager | isUserAllowedToPrintReports)
	openFormWindow(->[Reports:73]; "SR_CustomerTransactionStats")
Else 
	myAlert_AccessDenied
End if 