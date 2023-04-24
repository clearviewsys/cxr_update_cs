//%attributes = {}
// isHighRiskCountryCode (industryCode : ISO-2-chars) : boolean
// returns true if countryCode belongs to the collection of highRisk countries
// see also: initStorageObject
// see also: test_isHighRiskIndustryCode for unit testing

#DECLARE($industryCode : Text)->$isHighRisk : Boolean


If (($industryCode#"") & (Storage:C1525.AML_highRisk.industryCodes.indexOf($industryCode)>=0))
	return True:C214
Else 
	return False:C215
End if 

