//%attributes = {}
//author: Amir
//date: 6th Oct. 2018
// display annual summary screen report


If (isUserManager | isUserAllowedToPrintReports)
	openFormWindow(->[Reports:73]; "SR_AnnualSummary")
Else 
	myAlert_AccessDenied
End if 