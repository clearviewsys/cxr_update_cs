//%attributes = {}
C_TEXT:C284($1; $root)
C_TEXT:C284($report_indicators; $tmp; $element)

Case of 
	: (Count parameters:C259=1)
		$root:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$report_indicators:=GAML_CreateXMLNode($root; "report_indicators")
$tmp:="DIA"
$element:=GAML_CreateXMLNode($report_indicators; "indicator"; ->$tmp)