//%attributes = {}
//display_SR_TransactionSummary
If (isUserManager | isUserAllowedToPrintReports)
	displayTableForm(->[Reports:73]; "SR_TransactionSummary")
Else 
	myAlert_ManagerPrivilegeNeeded
End if 