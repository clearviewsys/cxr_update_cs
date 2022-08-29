//%attributes = {"shared":true}
If (isUserManager | isUserAllowedToPrintReports)
	displayTableForm(->[Reports:73]; "SR_UserTrans")
Else 
	myAlert_ManagerPrivilegeNeeded
End if 