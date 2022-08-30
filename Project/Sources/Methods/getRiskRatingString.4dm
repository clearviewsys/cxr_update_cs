//%attributes = {}
// getRiskRatingString (integer {1-5})
C_TEXT:C284($riskString; $0)
C_LONGINT:C283($risk; $1)

Case of 
	: (Count parameters:C259=0)
		$risk:=3
	: (Count parameters:C259=1)
		$risk:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($arrRisk; 5)  // from very low to very high
If (($risk>0) & ($risk<6))
	LIST TO ARRAY:C288("AML_RiskRating"; $arrRisk)
	$riskString:=$arrRisk{$risk}
Else 
	$riskString:="Undefined"
End if 

$0:=$riskString