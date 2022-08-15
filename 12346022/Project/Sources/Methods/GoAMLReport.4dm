//%attributes = {}
If (RAL2_isLicenseValid("AML_BR"))
	If (isUserManager | isUserAllowedToPrintReports)
		displayGoAMLReportPage
	Else 
		// Please ask administrator to give you access to this function. (Managers only)
		myAlert("Please ask administrator to give you access to this function. (Managers only)")
	End if 
Else 
	
	myAlert("You are currently not subscribed to this service, or your license has expired."\
		+" Please contact Clear View Systems Support and ask about our "\
		+"AML_BR Service."; "Message from Clear View Systems")
End if 
