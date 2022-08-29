//%attributes = {}
C_LONGINT:C283($index; $1)
C_TEXT:C284($riskString; $0)

$index:=$1

Case of 
	: ($index=0)
		$riskString:="Unassigned Risk"
	: ($index=1)
		$riskString:="Unknown Risk"
	: ($index=2)
		$riskString:="Lower Risk"
	: ($index=3)
		$riskString:="Moderate Risk"
	: ($index=4)
		$riskString:="High Risk"
	: ($index=5)
		$riskString:="High Risk with high certainty!"
	Else 
		
End case 

$0:=$riskString