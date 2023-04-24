//%attributes = {}
// FT_generatePartE1_EFT

C_TEXT:C284($1; $fileName)

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($tmp; $surname; $givenname; $middle; $streetAddress; $city; $country)
C_TEXT:C284($state; $zipCode; $indHomePhoneNumber; $indDateOfBirth; $indOccupation)
C_TEXT:C284($account; $indTypeOtherDesc; $indNum)
C_BLOB:C604($content)
C_TEXT:C284($companyName; $surnameAndOthers)

// -----------------------------------------------------------------------------------------------------------
// Part E: Part E – Information about the receiver of the EFT (i.e., the individual or entity that receives 
// the payment instructions)
// This part is for information about the individual or entity to which you are sending the payment instructions.
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


// Part ID
$tmp:="E1"
TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)


$companyName:=FT_StringFormat(reportingEntityName; 45)
TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)


// surname
$surnameAndOthers:=FT_StringFormat(" "; 45)
TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Street address
$streetAddress:=FT_StringFormat(" "; 30)
TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
$city:=FT_StringFormat(" "; 25)
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_StringFormat(" "; 2)
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Province/State
$state:=FT_StringFormat(" "; 20)
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)

// Postal/zip code
$zipCode:=FT_StringFormat(" "; 9)
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)


AppendBlobToFile($fileName; $content)



