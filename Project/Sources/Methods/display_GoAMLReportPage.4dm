//%attributes = {}
openFormWindow(->[CompanyInfo:7]; "goAMLInfo")

If (False:C215)
	If (<>COUNTRYCODE="NZ")
		openFormWindow(->[CompanyInfo:7]; "goAMLInfo")
	Else 
		myAlert("This feature is only available to NZ customers")
	End if 
	
End if 
