//%attributes = {}

// PersonFromWireSender

C_TEXT:C284($1; $node; $fromPerson; $tPerson; $element; $phones; $contactType; $commType; $addresses; $address; $addressType)
C_TEXT:C284($birthDate)


Case of 
	: (Count parameters:C259=1)
		$node:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_LONGINT:C283($pos)
C_TEXT:C284($element; $fn; $ln)


// If $t_conductor is Company Is not possible to report this information
$pos:=Position:C15(" "; [Wires:8]OriginatorFullName:34)
$fn:=Substring:C12([Wires:8]OriginatorFullName:34; 1; $pos-1)
$ln:=Substring:C12([Wires:8]OriginatorFullName:34; $pos+1)

$fn:=FJ_Trim($fn)
$element:=GAML_CreateXMLNode($node; "first_name"; ->$fn)
$ln:=FJ_Trim($ln)
$element:=GAML_CreateXMLNode($node; "last_name"; ->$ln)
