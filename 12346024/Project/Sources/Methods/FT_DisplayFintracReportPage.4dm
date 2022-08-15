//%attributes = {}
openFormWindow(->[CompanyInfo:7]; "FintracInfo")
If (False:C215)
	
	If (<>COUNTRYCODE="CA")
		openFormWindow(->[CompanyInfo:7]; "FintracInfo")
	Else 
		myAlert("This feature is only available to CANADIAN customers")
	End if 
	
End if 

