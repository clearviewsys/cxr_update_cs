//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_PartD : 
// Information about the individual conducting the transaction that is not a 
// deposit into a business account (if applicable)
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/10/2015
// ------------------------------------------------------------------------------


C_TEXT:C284($1)  // Report file path (include file name)      


C_TEXT:C284($2)  // Part ID
C_LONGINT:C283($3)  // Part sequence number

C_TEXT:C284($4)  // Surname
C_TEXT:C284($5)  // Given name
C_TEXT:C284($6)  // Other name/initial
C_TEXT:C284($7)  // Entity client number

C_TEXT:C284($8)  // Street address
C_TEXT:C284($9)  // City
C_TEXT:C284($10)  // Country
C_TEXT:C284($11)  // Province/State
C_TEXT:C284($12)  // Postal/zip code

C_TEXT:C284($13)  // Country of residence
C_TEXT:C284($14)  // Home telephone number
C_TEXT:C284($15)  // Individual's identifier ex.: A: Driver's licence, B Birth certificate
C_TEXT:C284($16)  // Id type Other description for code  'E' in $idType
C_TEXT:C284($17)  // Id Number
C_TEXT:C284($18)  // Country of issue
C_TEXT:C284($19)  // Province/State of issue
C_TEXT:C284($20)  // Individual's date of birth
C_TEXT:C284($21)  // Individual's occupation
C_TEXT:C284($22)  // Individual's business telephone number
C_TEXT:C284($23)  // Individual's business telephone extension number

C_BLOB:C604($content)
C_TEXT:C284($partId; $partSeqNum; $surname; $givenName; $otherName; $clientNumber; $streetAddress; $city; $country; $state; $zipCode)
C_TEXT:C284($countryOfResidence; $indHomePhoneNumber; $indType; $indTypeOtherDesc; $indNum; $indIssueCountry; $indIssueState)
C_TEXT:C284($indDateOfBirth; $indOccupation; $indBussinesPhonev; $indBussinesPhone; $indBussinesPhoneExt)
// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$partSeqNum:=FT_NumberFormat($3; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($partSeqNum; $content; UTF8 text without length:K22:17; *)

// Surname
$surname:=FT_StringFormat($4; 20)
TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Given name
$givenName:=FT_StringFormat($5; 15)
TEXT TO BLOB:C554($givenName; $content; UTF8 text without length:K22:17; *)

// Other name/initial
$otherName:=FT_StringFormat($6; 10)
TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)

// Entity client number
$clientNumber:=FT_StringFormat($7; 12)
TEXT TO BLOB:C554($clientNumber; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------


// Street address
$streetAddress:=FT_StringFormat($8; 30)
TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
$city:=FT_StringFormat($9; 25)
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_StringFormat($10; 2)
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Province/State
$state:=FT_StringFormat($11; 20)
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)

// Postal/zip code
$zipCode:=FT_StringFormat($12; 9)
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)

// Country of residence
$countryOfResidence:=FT_StringFormat($13; 2)
TEXT TO BLOB:C554($countryOfResidence; $content; UTF8 text without length:K22:17; *)

// Home telephone number
$indHomePhoneNumber:=FT_StringFormat($14; 20)
TEXT TO BLOB:C554($indHomePhoneNumber; $content; UTF8 text without length:K22:17; *)

// Individual's identifier
$indType:=FT_StringFormat($15; 1)
TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)

// Id type Other description for code  'E' in $idType
$indTypeOtherDesc:=FT_StringFormat($16; 20)
TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)

// ID number
$indNum:=FT_StringFormat($17; 20)
TEXT TO BLOB:C554($indNum; $content; UTF8 text without length:K22:17; *)

// Country of issue
$indIssueCountry:=FT_StringFormat($18; 2)
TEXT TO BLOB:C554($indIssueCountry; $content; UTF8 text without length:K22:17; *)


// Province/State of issue
$indIssueState:=FT_StringFormat($19; 20)
TEXT TO BLOB:C554($indIssueState; $content; UTF8 text without length:K22:17; *)

// Individual's date of birth
$indDateOfBirth:=FT_StringFormat($20; 8)
TEXT TO BLOB:C554($indDateOfBirth; $content; UTF8 text without length:K22:17; *)

// Individual's occupation
$indOccupation:=FT_StringFormat($21; 30)
TEXT TO BLOB:C554($indOccupation; $content; UTF8 text without length:K22:17; *)

// Individual's business telephone number
If ($22#"")
	$indBussinesPhone:=FT_StringFormat($22; 20)
Else 
	$indBussinesPhone:=FT_StringFormat(" "; 20)
End if 

TEXT TO BLOB:C554($indBussinesPhone; $content; UTF8 text without length:K22:17; *)

// Individual's business telephone extension number


If ($23#"")
	$indBussinesPhoneExt:=FT_StringFormat($23; 10; "0"; "RJ")
Else 
	$indBussinesPhoneExt:=FT_StringFormat(" "; 10; " "; "RJ")
End if 


TEXT TO BLOB:C554($indBussinesPhoneExt; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($1; $content)








