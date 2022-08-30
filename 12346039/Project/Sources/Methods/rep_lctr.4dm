//%attributes = {}
If (isUserManager | isUserAllowedToPrintReports)
	displayTableForm(->[CompanyInfo:7]; "FintracInfo")
Else 
	myAlert("Please ask administrator to give you access to this function. (Managers only)")
End if 