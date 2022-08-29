//%attributes = {}
// checkThreeStateExpectedValue (threestateCheckbox: value;"label")


C_LONGINT:C283($1; $checkboxValue)
C_TEXT:C284($2; $fieldValue)
C_TEXT:C284($3; $fieldlabel)

Case of 
	: (Count parameters:C259=3)
		$checkboxValue:=$1
		$fieldValue:=$2
		$fieldlabel:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: ($checkboxValue=1)  // mandatory
		checkAddErrorIf(($fieldValue=""); "<X> cannot be left blank."; $fieldlabel)
	: ($checkboxValue=2)  // optional 
		checkAddWarningOnTrue(($fieldValue=""); "<X> is missing."; $fieldlabel)
End case 
