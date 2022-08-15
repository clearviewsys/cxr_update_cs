//%attributes = {}
// GAML_Node_FromEntity_ForWires

C_TEXT:C284($1; $from)

Case of 
	: (Count parameters:C259=1)
		$from:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($element)
$element:=GAML_CreateXMLNode($from; "name"; ->[Wires:8]OriginatingBankName:43)



