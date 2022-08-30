//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_PartE : 
// Information about the individual conducting the transaction that is a deposit 
// into a business account (other than a quick drop or night deposit) (if applicable)
//
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/11/2015
// ------------------------------------------------------------------------------


C_TEXT:C284($1)  // Report file path (include file name)      


C_TEXT:C284($2)  // Part ID
C_LONGINT:C283($3)  // Part sequence number

C_TEXT:C284($4)  // Surname
C_TEXT:C284($5)  // Given name
C_TEXT:C284($6)  // Other name/initial

C_BLOB:C604($content)
C_TEXT:C284($partId; $repSeqNum; $surname; $givenName; $otherName)
// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$repSeqNum:=FT_NumberFormat($3; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($repSeqNum; $content; UTF8 text without length:K22:17; *)

// Surname
$surname:=FT_StringFormat($4; 20)
TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)

// Given name
$givenName:=FT_StringFormat($5; 15)
TEXT TO BLOB:C554($givenName; $content; UTF8 text without length:K22:17; *)

// Other name/initial
$otherName:=FT_StringFormat($6; 10)
TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($1; $content)



