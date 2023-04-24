//%attributes = {}
// displayReport_ItemsPL
// opens the P&L Summary ListBox for Items

If (isUserAllowedToViewProfits)
	openFormWindow(->[Reports:73]; "PL_Items")
Else 
	myAlert_AccessDenied
End if 