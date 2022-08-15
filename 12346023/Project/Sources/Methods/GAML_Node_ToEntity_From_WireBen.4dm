//%attributes = {}
// GAML_Node_ToEntity_From_WireBen

C_TEXT:C284($0)
C_TEXT:C284($1; $to)

Case of 
		
	: (Count parameters:C259=1)
		$to:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($element)

$element:=GAML_CreateXMLNode($to; "name"; ->[Wires:8]BeneficiaryFullName:10)

GAML_SetPhones($to; ->[Wires:8]BeneficiaryBranchPhone:30)
GAML_SetAddress($to; ->[Wires:8]BeneficiaryAddress:26; ->[Wires:8]BeneficiaryCity:50; ->[Wires:8]BeneficiaryState:51; ->[Wires:8]BeneficiaryZIPCode:52; ->[Wires:8]BeneficiaryCity:50)

