//%attributes = {"shared":true}

If (isUserManager | isUserAllowedToPrintReports)
	displayTableForm(->[Reports:73]; "SR_CustomerTrans")
Else 
	myAlert_ManagerPrivilegeNeeded
End if 