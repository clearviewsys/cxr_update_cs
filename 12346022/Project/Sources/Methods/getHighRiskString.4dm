//%attributes = {}
// getHighRiskString (highRiskValue of checkbox or field) : string

C_LONGINT:C283($1; $highRisk)
C_TEXT:C284($0; $riskString)

Case of 
	: (Count parameters:C259=0)
		$highRisk:=1  // for testing
		
	: (Count parameters:C259=1)
		$highRisk:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: ($highRisk=0)
		$riskString:="unassigned"
	: ($highRisk=1)
		$riskString:="High Risk"
	: ($highRisk=2)
		$riskString:="Not High Risk"
	Else 
		//ASSERT(False;"Invalid value")
End case 

$0:=$riskString