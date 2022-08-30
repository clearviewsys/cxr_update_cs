//%attributes = {}

// GAML_NodeT_PersonFromCustomer

C_TEXT:C284($1; $t_conductor; $fromPerson; $tPerson; $element; $phones; $contactType; $commType; $addresses; $address; $addressType)
C_TEXT:C284($0; $na)
C_TEXT:C284($from_entity; $element; $phones; $addresses)


Case of 
	: (Count parameters:C259=1)
		$from_entity:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//$tPerson:=GAML_CreateXMLNode ($t_from;"t_person")
//$t_entity:=GAML_CreateXMLNode ($t_from;"t_entity")

// The customer is a company report it in node t_entity


$element:=GAML_CreateXMLNode($from_entity; "name"; ->[ThirdParties:101]CompanyName:23)
$element:=GAML_CreateXMLNode($from_entity; "commercial_name"; ->[ThirdParties:101]CompanyName:23)
$element:=GAML_CreateXMLNode($from_entity; "incorporation_number"; ->[ThirdParties:101]IncorporationNumber:25)
$element:=GAML_CreateXMLNode($from_entity; "business"; ->[ThirdParties:101]BusinessType:24)


$phones:=GAML_CreateXMLNode($from_entity; "phones")

$contactType:="I"  // I-Home Adress, S-Work
$commType:="C"  // C-Mobile Phone, B-Landline phone
GAML_SetPhone($phones; $contactType; $commType; [ThirdParties:101]HomePhone:10)

$contactType:="S"  // I-Home Adress, S-Work
$commType:="B"  // C-Mobile Phone, B-Landline phone
GAML_SetPhone($phones; $contactType; $commType; [ThirdParties:101]WorkPhone:11)



$addresses:=GAML_CreateXMLNode($from_entity; "addresses")
$address:=GAML_CreateXMLNode($addresses; "address")

$addressType:="B"  // C-Business address
$element:=GAML_CreateXMLNode($address; "address_type"; ->$addressType)
$element:=GAML_CreateXMLNode($address; "address"; ->[ThirdParties:101]Address:6)
$element:=GAML_CreateXMLNode($address; "city"; ->[ThirdParties:101]City:7)
$element:=GAML_CreateXMLNode($address; "zip"; ->[ThirdParties:101]ZipCode:9)
$element:=GAML_CreateXMLNode($address; "country_code"; ->[ThirdParties:101]CountryCode:8)
$element:=GAML_CreateXMLNode($address; "state"; ->[ThirdParties:101]theState:29)

$element:=GAML_CreateXMLNode($from_entity; "incorporation_country_code"; ->[ThirdParties:101]IdCountryOfIssue:18)
$element:=GAML_CreateXMLNode($from_entity; "incorporation_state"; ->$na)


