//%attributes = {}
openFormWindow(->[CompanyInfo:7]; "FijiFIUReports")

If (False:C215)
	
	If (<>COUNTRYCODE="FJ")
		openFormWindow(->[CompanyInfo:7]; "FijiFIUReports")
	Else 
		myAlert("This feature is only available to Fiji customers")
	End if 
	
End if 
