//%attributes = {}
//author: Amir
//date: 5th Sept. 2018
// displayReport_SubAccountTransfer


If (isUserManager | isUserAllowedToPrintReports)
	openFormWindow(->[Reports:73]; "SR_SubAccountsSummary")
Else 
	myAlert_AccessDenied
End if 