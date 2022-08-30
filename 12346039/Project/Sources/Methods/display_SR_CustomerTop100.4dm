//%attributes = {}
//display_SR_CustomerTop100
If (isUserManager | isUserAllowedToPrintReports)
	displayTableForm(->[Reports:73]; "SR_Top100Customers")
Else 
	myAlert_ManagerPrivilegeNeeded
End if 