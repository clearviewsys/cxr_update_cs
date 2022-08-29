//%attributes = {}
// GAML_Node_FromPerson_ForWires



C_TEXT:C284($1; $from; $fromPerson; $tPerson; $element; $phones; $contactType; $commType; $addresses; $address; $addressType)
C_TEXT:C284($birthDate)


Case of 
	: (Count parameters:C259=1)
		$from:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_LONGINT:C283($p)
C_TEXT:C284($tmp)


$element:=GAML_CreateXMLNode($from; "gender"; ->[Wires:8]OriginatorFullName:34)
$p:=Position:C15(" "; [Wires:8]OriginatorFullName:34; 1)
If ($p>0)
	$tmp:=Substring:C12([Wires:8]OriginatorFullName:34; 1; $p-1)
	$element:=GAML_CreateXMLNode($from; "first_name"; ->$tmp)
	
	$tmp:=Substring:C12([Wires:8]OriginatorFullName:34; $p+1)
	$element:=GAML_CreateXMLNode($from; "last_name"; ->$tmp)
Else 
	$tmp:=" "
	$element:=GAML_CreateXMLNode($from; "first_name"; ->[Wires:8]OriginatorFullName:34)
	$element:=GAML_CreateXMLNode($from; "last_name"; ->$tmp)
End if 


$element:=GAML_CreateXMLNode($from; "id_ number"; ->[Wires:8]OriginatorIdentifier:35)

GAML_SetAddress($from; ->[Wires:8]OriginatorAddress:36; ->[Wires:8]OriginatorCity:37; ->[Wires:8]OriginatorState:38; ->[Wires:8]OriginatorZIP:40; ->[Wires:8]OriginatorCountry:39)


$0:=$element  // added by TB to prevent the compiler error


