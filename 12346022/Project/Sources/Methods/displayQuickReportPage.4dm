//%attributes = {"shared":true}

C_POINTER:C301($1; quickReportTablePtr)

Case of 
		
	: (Count parameters:C259=0)
		quickReportTablePtr:=Current form table:C627
		
	: (Count parameters:C259=1)
		quickReportTablePtr:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (isUserAllowedToPrintReports)
	openFormWindow(->[CompanyInfo:7]; "QuickReportPage")
Else 
	myAlert("Reporting privilege required!")
End if 