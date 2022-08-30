//%attributes = {}
// PL_displaySummaries

// opens the P&L Summary ListBox 
If (isUserAllowedToViewProfits)
	openFormWindow(->[Reports:73]; "PL_Currencies")
Else 
	myAlert_AccessDenied
End if 