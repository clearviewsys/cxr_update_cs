//%attributes = {}
If (isUserManager | isUserAllowedToPrintReports)
	displayFintracReportPage
Else 
	// Please ask administrator to give you access to this function. (Managers only)
	myAlert("Please ask administrator to give you access to this function. (Managers only)")
End if 