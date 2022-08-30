//%attributes = {}
// GAML_Node_ToPerson_From_WireBen

C_TEXT:C284($0)
C_TEXT:C284($1; $to)

Case of 
		
	: (Count parameters:C259=1)
		$to:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($tmp; $element; $from)
C_LONGINT:C283($p)


$element:=GAML_CreateXMLNode($to; "gender"; ->[Wires:8]BeneficiaryGender:72)

$p:=Position:C15(" "; [Wires:8]BeneficiaryFullName:10; 1)
If ($p>0)
	$tmp:=Substring:C12([Wires:8]BeneficiaryFullName:10; 1; $p-1)
	$element:=GAML_CreateXMLNode($to; "first_name"; ->$tmp)
	
	$tmp:=Substring:C12([Wires:8]BeneficiaryFullName:10; $p+1)
	$element:=GAML_CreateXMLNode($to; "last_name"; ->$tmp)
Else 
	$tmp:=" "
	$element:=GAML_CreateXMLNode($to; "first_name"; ->[Wires:8]BeneficiaryFullName:10)
	$element:=GAML_CreateXMLNode($to; "last_name"; ->$tmp)
End if 


GAML_SetAddress($from; ->[Wires:8]BeneficiaryAddress:26; ->[Wires:8]BeneficiaryCity:50; ->[Wires:8]BeneficiaryState:51; ->[Wires:8]BeneficiaryZIPCode:52; ->[Wires:8]BeneficiaryCountry:53)

