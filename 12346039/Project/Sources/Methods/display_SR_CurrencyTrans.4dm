//%attributes = {"shared":true}
If (isUserManager | isUserAllowedToPrintReports)
	displayTableForm(->[Reports:73]; "SR_Currencies")
Else 
	myAlert_ManagerPrivilegeNeeded
End if 