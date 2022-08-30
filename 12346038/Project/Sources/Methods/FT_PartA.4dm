//%attributes = {}


// ------------------------------------------------------------------------------
// Method: FT_PartA : 
// Information about where the transaction took place
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/14/2015
// ------------------------------------------------------------------------------


C_TEXT:C284($1)  // Report file path (include file name)      
C_TEXT:C284($2)  // Part ID
C_LONGINT:C283($3)  // Report sequence number
C_TEXT:C284($4)  // Reporting entity report reference number

C_TEXT:C284($5)  // Action code
C_TEXT:C284($6)  // Reporting entity's identifier number
C_TEXT:C284($7)  // Reporting entity's location number

C_TEXT:C284($8)  // Contact's surname
C_TEXT:C284($9)  // Contact's given name
C_TEXT:C284($10)  // Contact's other name/initial

C_TEXT:C284($11)  // Contact person telephone number
C_TEXT:C284($12)  // Contact person telephone extension number
C_TEXT:C284($13)  // Type of reporting entity
C_TEXT:C284($14)  // 24-hour rule indicator

C_BLOB:C604($content)
C_TEXT:C284($partId; $repSeqNum; $repEntityRefNum; $actionCode; $repEntityIdNum; $repEntityLocNum; \
$contactSurName; $contactGivenName; $contactPhoneNumber; $contactPhoneNumberExt; $entityType; \
$rule24Indicator; $contactOtherName)

// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Report sequence number
$repSeqNum:=FT_NumberFormat($3; 0; 5; "0"; "RJ")
TEXT TO BLOB:C554($repSeqNum; $content; UTF8 text without length:K22:17; *)

// Reporting entity report reference number
$repEntityRefNum:=FT_StringFormat($4; 20; " "; "LJ")
TEXT TO BLOB:C554($repEntityRefNum; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Action code
$actionCode:=FT_StringFormat($5; 1)
TEXT TO BLOB:C554($actionCode; $content; UTF8 text without length:K22:17; *)

// Reporting entity's identifier number
$repEntityIdNum:=FT_StringFormat($6; 7; "0"; "RJ")
TEXT TO BLOB:C554($repEntityIdNum; $content; UTF8 text without length:K22:17; *)


// Reporting entity's location number
If ($7="")
	$repEntityLocNum:=FT_StringFormat(getKeyValue("FT.MainBranchLocNumber"); 15; " "; "LJ")
Else 
	$repEntityLocNum:=FT_StringFormat($7; 15; " "; "LJ")
End if 


TEXT TO BLOB:C554($repEntityLocNum; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------
// Contact's surname
$contactSurName:=FT_StringFormat($8; 20; " "; "LJ")
TEXT TO BLOB:C554($contactSurName; $content; UTF8 text without length:K22:17; *)

// Contact's given name
$contactGivenName:=FT_StringFormat($9; 15; " "; "LJ")
TEXT TO BLOB:C554($contactGivenName; $content; UTF8 text without length:K22:17; *)

// Contact's other name/initial
$contactOtherName:=FT_StringFormat($10; 10; " "; "LJ")
TEXT TO BLOB:C554($contactOtherName; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------
// Contact person telephone number
$contactPhoneNumber:=FT_StringFormat($11; 20; " "; "LJ")
TEXT TO BLOB:C554($contactPhoneNumber; $content; UTF8 text without length:K22:17; *)

// Contact person telephone extension number TODO: Format using "-"
$contactPhoneNumberExt:=FT_StringFormat($12; 10; "0"; "RJ")
TEXT TO BLOB:C554($contactPhoneNumberExt; $content; UTF8 text without length:K22:17; *)

// Type of reporting entity
$entityType:=FT_StringFormat($13; 1; " "; "LJ")
TEXT TO BLOB:C554($entityType; $content; UTF8 text without length:K22:17; *)

// 24-hour rule indicator
$rule24Indicator:=FT_StringFormat($14; 1; "0"; "LJ")
TEXT TO BLOB:C554($rule24Indicator; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($1; $content)







