//%attributes = {}
// FT_generatePartE1

C_TEXT:C284($1; $fileName)

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BLOB:C604($content)
C_TEXT:C284($tmp; $tmp1)
C_TEXT:C284($companyName; $surnameAndOthers; $streetAddress; $city; $country; $state; $zipCode)
C_TEXT:C284($surname; $name; $otherName)

// -----------------------------------------------------------------------------------------------------------
// Part E: Part E – Information about the receiver of the EFT (i.e., the individual or entity that receives 
// the payment instructions)
// This part is for information about the individual or entity to which you are sending the payment instructions.
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


// Part ID
$tmp:="E1"
TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)

Case of 
		
	: ([eWires:13]isBeneficiaryCompany:93)
		
		// Company Name
		$companyName:=FT_StringFormat([eWires:13]BeneficiaryCompanyName:92; 45)
		TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
		
		// surname
		$surnameAndOthers:=FT_StringFormat(" "; 45)
		TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
		
		
	: ([eWires:13]isBeneficiaryCompany:93=False:C215)
		
		$companyName:=FT_StringFormat(" "; 45)
		TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
		
		// surname
		$surname:=FT_GetLastName([eWires:13]BeneficiaryFullName:5)
		$surname:=FT_StringFormat($surname; 20)
		TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)
		
		// Given Name
		$name:=FT_GetFirstName([eWires:13]BeneficiaryFullName:5)
		$name:=FT_StringFormat($name; 15)
		TEXT TO BLOB:C554($name; $content; UTF8 text without length:K22:17; *)
		
		// Other Name
		$otherName:=FT_StringFormat(" "; 10)
		TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)
		
		
End case 


// -----------------------------------------------------------

// Street address
$streetAddress:=FT_StringFormat([eWires:13]BeneficiaryAddress:59; 30)
TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
$city:=FT_StringFormat([eWires:13]BeneficiaryCity:60; 25)
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_StringFormat([eWires:13]toCountry:10; 2)
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Province/State
$state:=FT_StringFormat(" "; 20)
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)

// Postal/zip code
$zipCode:=FT_StringFormat(" "; 9)
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)


AppendBlobToFile($fileName; $content)


