//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_PartG : 
// Information about the individual on whose behalf the transaction was 
// conducted (if applicable) 
//
// This part only applies if the disposition was conducted on behalf of a third party 
// other than an individual, as indicated in Part B2. To include Part F, the on behalf 
// of indicator in Part B2 (field B13) has to be “E”.
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/13/2015
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $repFileParh)  // Report file path (include file name)      


C_TEXT:C284($2)  // Part ID
C_LONGINT:C283($3)  // Part sequence number

C_TEXT:C284($4)  // Surname
C_TEXT:C284($5)  // Given name
C_TEXT:C284($6)  // Other name/initial

C_TEXT:C284($7)  // Street address
C_TEXT:C284($8)  // City
C_TEXT:C284($9)  // Country
C_TEXT:C284($10)  // Province/State
C_TEXT:C284($11)  // Postal/zip code

C_TEXT:C284($12)  // Home  telephone number
C_TEXT:C284($13)  // Business telephone number
C_TEXT:C284($14)  // Business telephone number extension

C_TEXT:C284($15)  // Individual's date of birth
C_TEXT:C284($16)  // Individual's identifier
C_TEXT:C284($17)  // Other description

C_TEXT:C284($18)  // ID Number
C_TEXT:C284($19)  // Country of residence
C_TEXT:C284($20)  // Country of issue
C_TEXT:C284($21)  // Province/State of issue
C_TEXT:C284($22)  // Individual's occupation

C_TEXT:C284($23)  // Relationship to individual
C_TEXT:C284($24)  // Other relationship

C_BLOB:C604($content)
C_TEXT:C284($partId; $partSeqNum; $surname; $givenName; $otherName; $streetAddress; $city; $country; $state)
C_TEXT:C284($zipCode; $homeTelNum; $businessTelNum; $businessTelNumExt; $indDateOfBirthday; $indIdentifier; $otherRel)
C_TEXT:C284($otherDescription; $idNumber; $countryOfRes; $countryOfIssue; $issueState; $indOccupation; $indRelation)
// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$partSeqNum:=FT_NumberFormat($3; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($partSeqNum; $content; UTF8 text without length:K22:17; *)

// Surname
$surname:=FT_StringFormat($4; 20)
TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)

// Given name
$givenName:=FT_StringFormat($5; 15)
TEXT TO BLOB:C554($givenName; $content; UTF8 text without length:K22:17; *)

// Other name/initial
$otherName:=FT_StringFormat($6; 10)
TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)

// Street address
$streetAddress:=FT_StringFormat($7; 30)
TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
$city:=FT_StringFormat($8; 25)
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_StringFormat($9; 2)
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)

// Province/State
$state:=FT_StringFormat($10; 20)
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)

// Postal/zip code
$zipCode:=FT_StringFormat($11; 9)
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)

// Home  telephone number
$homeTelNum:=FT_StringFormat($12; 20)
TEXT TO BLOB:C554($homeTelNum; $content; UTF8 text without length:K22:17; *)

// Office telephone number
$businessTelNum:=FT_StringFormat($13; 20)
TEXT TO BLOB:C554($businessTelNum; $content; UTF8 text without length:K22:17; *)

// Office telephone extension number
$businessTelNumExt:=FT_StringFormat($14; 10; "0"; "RJ")
TEXT TO BLOB:C554($businessTelNumExt; $content; UTF8 text without length:K22:17; *)

// Individual's date of birth
$indDateOfBirthday:=FT_StringFormat($15; 8)
TEXT TO BLOB:C554($indDateOfBirthday; $content; UTF8 text without length:K22:17; *)

// Individual's identifier
$indIdentifier:=FT_StringFormat($16; 1)
TEXT TO BLOB:C554($indIdentifier; $content; UTF8 text without length:K22:17; *)

// Other description
$otherDescription:=FT_StringFormat($17; 20)
TEXT TO BLOB:C554($otherDescription; $content; UTF8 text without length:K22:17; *)


// ID number
$idNumber:=FT_StringFormat($18; 20)
TEXT TO BLOB:C554($idNumber; $content; UTF8 text without length:K22:17; *)

// Country of residence
$countryOfRes:=FT_StringFormat($19; 2)
TEXT TO BLOB:C554($countryOfRes; $content; UTF8 text without length:K22:17; *)

// Country of issue
$countryOfIssue:=FT_StringFormat($20; 2)
TEXT TO BLOB:C554($countryOfIssue; $content; UTF8 text without length:K22:17; *)

// Province/State of issue
$issueState:=FT_StringFormat($21; 20)
TEXT TO BLOB:C554($issueState; $content; UTF8 text without length:K22:17; *)


// Individual's occupation
$indOccupation:=FT_StringFormat($22; 30)
TEXT TO BLOB:C554($indOccupation; $content; UTF8 text without length:K22:17; *)

// Relationship to individual
$indRelation:=FT_StringFormat($23; 1)
TEXT TO BLOB:C554($indRelation; $content; UTF8 text without length:K22:17; *)

// Other relationship: This field is required if code "J" is entered in field "Relationship to individual"
$otherRel:=FT_StringFormat($24; 20)
TEXT TO BLOB:C554($otherRel; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($1; $content)




