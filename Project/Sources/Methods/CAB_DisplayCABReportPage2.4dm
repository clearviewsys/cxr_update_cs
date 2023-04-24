//%attributes = {}
openFormWindow(->[CompanyInfo:7]; "AustractReports")


If (False:C215)
	
	If (<>COUNTRYCODE="NZ")
		openFormWindow(->[CompanyInfo:7]; "AustractReports")
	Else 
		myAlert("This feature is only available to Fiji customers")
	End if 
	
End if 
