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


// If $t_conductor is Company Is not possible to report this information


$element:=GAML_CreateXMLNode($from_person; "gender"; ->[Customers:3]Gender:120)
$element:=GAML_CreateXMLNode($from_person; "first_name"; ->[Customers:3]FirstName:3)
$element:=GAML_CreateXMLNode($from_person; "last_name"; ->[Customers:3]LastName:4)
$birthDate:=FT_GetStringDate([eWires:13]senderDOB:101; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")

$element:=GAML_CreateXMLNode($from_person; "birthdate"; ->$birthDate)
//$element:=GAML_CreateXMLNode ($from_person;"SSN";->[Customers]SIN_No)

If (([Customers:3]PictureID_IssueCountry:73="NZ") & ([Customers:3]PictureID_TemplateID:15="NZDL"))
	$element:=GAML_CreateXMLNode($from_person; "id_number"; ->[Customers:3]PictureID_Number:69)
End if 

$element:=GAML_CreateXMLNode($from_person; "occupation"; ->[Customers:3]Occupation:21)
$element:=GAML_CreateXMLNode($from_person; "employer_name"; ->[Customers:3]PictureID_GovernmentCode:20)
