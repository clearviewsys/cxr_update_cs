//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_PartF : 
//  Information about the entity on whose behalf the transaction was conducted. 
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

C_TEXT:C284($4)  // Corporation, trust or other entity name
C_TEXT:C284($5)  // Type of business

C_TEXT:C284($6)  // Street address
C_TEXT:C284($7)  // City
C_TEXT:C284($8)  // Country
C_TEXT:C284($9)  // Province/State
C_TEXT:C284($10)  // Postal/zip code

C_TEXT:C284($11)  // Business telephone number
C_TEXT:C284($12)  // Business telephone number extension
C_TEXT:C284($13)  // Incorporation number 
C_TEXT:C284($14)  // Country of issue
C_TEXT:C284($15)  // State of Issue
C_TEXT:C284($16)  // Individuals authorized to bind the entity or act with respect to the account Individual's name 1
C_TEXT:C284($17)  // Individuals authorized to bind the entity or act with respect to the account Individual's name 2
C_TEXT:C284($18)  // Individuals authorized to bind the entity or act with respect to the account Individual's name 3

C_BLOB:C604($content)
C_TEXT:C284($partId; $partSeqNum; $entityName; $businessType; $streetAddress; $city; $country; $state; $zipCode; $businessTelNum; $businessTelNumExt; $incNumber; $issueCountry)
C_TEXT:C284($issueState; $authorized1; $authorized2; $authorized3)
// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$partSeqNum:=FT_NumberFormat($3; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($partSeqNum; $content; UTF8 text without length:K22:17; *)

// Corporation, trust or other entity name
$entityName:=FT_StringFormat($4; 35)
TEXT TO BLOB:C554($entityName; $content; UTF8 text without length:K22:17; *)

// Type of business
$businessType:=FT_StringFormat($5; 20)
TEXT TO BLOB:C554($businessType; $content; UTF8 text without length:K22:17; *)


// Street address
$streetAddress:=FT_StringFormat($6; 30)
TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
$city:=FT_StringFormat($7; 25)
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_StringFormat($8; 2)
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)

// Province/State
$state:=FT_StringFormat($9; 20)
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)

// Postal/zip code
$zipCode:=FT_StringFormat($10; 9)
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)

// Business telephone number
$businessTelNum:=FT_StringFormat($11; 20)
TEXT TO BLOB:C554($businessTelNum; $content; UTF8 text without length:K22:17; *)

// Business telephone number extension
$businessTelNumExt:=FT_StringFormat($12; 10; "0"; "RJ")
TEXT TO BLOB:C554($businessTelNumExt; $content; UTF8 text without length:K22:17; *)

// Incorporation number 
$incNumber:=FT_StringFormat($13; 14)
TEXT TO BLOB:C554($incNumber; $content; UTF8 text without length:K22:17; *)

// Country of issue
$issueCountry:=FT_StringFormat($14; 2)
TEXT TO BLOB:C554($issueCountry; $content; UTF8 text without length:K22:17; *)

// Province/State of issue
$issueState:=FT_StringFormat($15; 20)
TEXT TO BLOB:C554($issueState; $content; UTF8 text without length:K22:17; *)


// Individuals authorized to bind the entity or act with respect to the account
// Individual's name 1
$authorized1:=FT_StringFormat($16; 35)
TEXT TO BLOB:C554($authorized1; $content; UTF8 text without length:K22:17; *)

// Individuals authorized to bind the entity or act with respect to the account
// Individual's name 2
$authorized2:=FT_StringFormat($17; 35)
TEXT TO BLOB:C554($authorized2; $content; UTF8 text without length:K22:17; *)

//Individuals authorized to bind the entity or act with respect to the account
// Individual's name 3
$authorized3:=FT_StringFormat($18; 35)
TEXT TO BLOB:C554($authorized3; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($1; $content)





