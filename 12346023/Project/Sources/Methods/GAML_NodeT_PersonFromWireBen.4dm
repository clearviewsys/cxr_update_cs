//%attributes = {}

// GAML_NodeT_PersonFromCustomer

C_TEXT:C284($1; $from_person; $fromPerson; $tPerson; $element; $phones; $contactType; $commType; $addresses; $address; $addressType)
C_TEXT:C284($birthDate)


Case of 
	: (Count parameters:C259=1)
		$from_person:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($pos)
C_TEXT:C284($element; $fn; $ln)

// If $t_conductor is Company Is not possible to report this information
$pos:=Position:C15(" "; [Wires:8]BeneficiaryFullName:10)
$fn:=Substring:C12([Wires:8]BeneficiaryFullName:10; 1; $pos-1)
$ln:=Substring:C12([Wires:8]BeneficiaryFullName:10; $pos+1)


$element:=GAML_CreateXMLNode($from_person; "gender"; ->[Wires:8]BeneficiaryGender:72)
$element:=GAML_CreateXMLNode($from_person; "title"; ->[Wires:8]BeneficiarySalutation:73)
$element:=GAML_CreateXMLNode($from_person; "first_name"; ->$fn)
$element:=GAML_CreateXMLNode($from_person; "last_name"; ->$ln)
$birthDate:=FT_GetStringDate([eWires:13]BeneficiaryDOB:110; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
$element:=GAML_CreateXMLNode($from_person; "birthdate"; ->$birthDate)  //TODO: Check. Beneficiary DOB Doesn't exist
//$element:=GAML_CreateXMLNode ($from_person;"SSN";->[Customers]SIN_No)
//$element:=GAML_CreateXMLNode ($from_person;"id_number";->[Customers]MainPictureID)
$element:=GAML_CreateXMLNode($from_person; "occupation"; ->[Customers:3]Occupation:21)  //TODO: Check
//$element:=GAML_CreateXMLNode ($from_person;"employer_name";->[Customers]EmployerName)
