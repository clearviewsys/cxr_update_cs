//%attributes = {}
// checkifKYCFieldMissing ([amlrules]requirementField: ->stringfield;"label")

C_LONGINT:C283($1; $requireKYCField)
C_TEXT:C284($2; $KYCFieldValue)
C_TEXT:C284($3; $fieldlabel)

$requireKYCField:=$1
$KYCFieldValue:=$2
$fieldlabel:=$3

Case of 
	: ($requireKYCField=1)  // mandatory
		checkAddErrorIf(($KYCFieldValue=""); $fieldlabel+" cannot be left blank.")
	: ($requireKYCField=2)  // optional 
		checkAddWarningOnTrue(($KYCFieldValue=""); $fieldlabel+" is missing.")
End case 
