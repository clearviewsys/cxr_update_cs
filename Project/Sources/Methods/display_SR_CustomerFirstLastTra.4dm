//%attributes = {"shared":true}
//display_SR_CustomerFirstLastTra
If (isUserManager | isUserAllowedToPrintReports)
	displayTableForm(->[Reports:73]; "SR_CustomerTransFirstLast")
Else 
	myAlert_ManagerPrivilegeNeeded
End if 