//%attributes = {}
// display_SR_BookingSummary
// opens the booking summary report

If (isUserManager | isUserAllowedToPrintReports)
	openFormWindow(->[Reports:73]; "SR_BookingSummary")
Else 
	myAlert_AccessDenied
End if 