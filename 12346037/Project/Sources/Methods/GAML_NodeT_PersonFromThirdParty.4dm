//%attributes = {}

// GAML_NodeT_PersonFromCustomer

C_TEXT:C284($1; $t_conductor; $fromPerson; $tPerson; $element; $phones; $contactType; $commType; $addresses; $address; $addressType)
C_TEXT:C284($0; $from_person; $element; $birthDate; $phones; $addresses)


Case of 
	: (Count parameters:C259=1)
		$from_person:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//$tPerson:=GAML_CreateXMLNode ($t_from;"t_person")

// If $t_conductor is Company Is not possible to report this information

$element:=GAML_CreateXMLNode($from_person; "first_name"; ->[ThirdParties:101]FirstName:4)
$element:=GAML_CreateXMLNode($from_person; "last_name"; ->[ThirdParties:101]LastName:3)
$birthDate:=FT_GetStringDate([ThirdParties:101]DOB:13; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
$element:=GAML_CreateXMLNode($from_person; "birthdate"; ->$birthDate)
$element:=GAML_CreateXMLNode($from_person; "id_number"; ->[ThirdParties:101]IdNumber:16)
$element:=GAML_CreateXMLNode($from_person; "Occupation"; ->[ThirdParties:101]Occupation:20)

If (False:C215)
	
	$phones:=GAML_CreateXMLNode($from_person; "phones")
	
	$contactType:="I"  // I-Home Adress, S-Work
	$commType:="C"  // C-Mobile Phone, B-Landline phone
	GAML_SetPhone($phones; $contactType; $commType; [ThirdParties:101]HomePhone:10)
	
	$contactType:="S"  // I-Home Adress, S-Work
	$commType:="B"  // C-Mobile Phone, B-Landline phone
	GAML_SetPhone($phones; $contactType; $commType; [ThirdParties:101]WorkPhone:11)
	
	
	If (([ThirdParties:101]Address:6#"") & ([ThirdParties:101]City:7#"") & ([ThirdParties:101]ZipCode:9#"") & ([ThirdParties:101]CountryCode:8#"") & ([ThirdParties:101]theState:29#""))
		
		$addresses:=GAML_CreateXMLNode($from_person; "addresses")
		$address:=GAML_CreateXMLNode($addresses; "address")
		
		$addressType:="B"  // C-Business address
		$element:=GAML_CreateXMLNode($address; "address_type"; ->$addressType)
		$element:=GAML_CreateXMLNode($address; "address"; ->[ThirdParties:101]Address:6)
		$element:=GAML_CreateXMLNode($address; "city"; ->[ThirdParties:101]City:7)
		$element:=GAML_CreateXMLNode($address; "zip"; ->[ThirdParties:101]ZipCode:9)
		$element:=GAML_CreateXMLNode($address; "country_code"; ->[ThirdParties:101]CountryCode:8)
		$element:=GAML_CreateXMLNode($address; "state"; ->[ThirdParties:101]theState:29)
	End if 
	//$element:=GAML_CreateXMLNode ($from_person;"residence";->[ThirdParties]CountryOfResidence)
End if 



$0:=$tPerson
