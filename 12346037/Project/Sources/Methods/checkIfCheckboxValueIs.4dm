//%attributes = {}
// checkThreeStateExpectedValue (threestateCheckbox: value;"label")


C_BOOLEAN:C305($1; $checkboxValue)
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
	: ($checkboxValue=True:C214)  // mandatory
		checkAddErrorIf(($fieldValue=""); "<X> cannot be left blank."; $fieldlabel)
End case 
