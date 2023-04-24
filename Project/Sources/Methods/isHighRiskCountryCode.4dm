//%attributes = {}
// isHighRiskCountryCode (countryCode : ISO-2-chars) : boolean
// returns true if countryCode belongs to the collection of highRisk countries
// see also: test_isHighRiskCountryCode
// see also: initStorageObject

#DECLARE($countryCode : Text)->$isHighRisk : Boolean

ASSERT:C1129(Count parameters:C259=1)

var $highRiskCountryCollection : Collection
$highRiskCountryCollection:=Storage:C1525.AML_highRisk.countryCodes

If ($highRiskCountryCollection.indexOf($countryCode)>=0)
	return True:C214
Else 
	return False:C215
End if 