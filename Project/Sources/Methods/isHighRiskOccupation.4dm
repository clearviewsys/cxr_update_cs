//%attributes = {}
// isHighRiskOccupation (occupation: text) : boolean
// returns true if countryCode belongs to the collection of highRisk countries


#DECLARE($occupation : Text)->$isHighRisk : Boolean

ASSERT:C1129(Count parameters:C259=1)

var $highRiskOccupations : Collection
// see also: initStorageObject
$highRiskOccupations:=Storage:C1525.AML_highRisk.occupations

If ($highRiskOccupations.indexOf($occupation)>=0)
	return True:C214
Else 
	return False:C215
End if 