//%attributes = {}


// ------------------------------------------------------------------------------
// Method: FT_SubHeader1B : 
// The batch sub-header contains information that allows you to group reports 
// included in the batch according to your organizational structure or any other 
// grouping need. The use of different sub-headers is optional, but you must include 
// at least one sub-header in a batch. 
//
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 01/29/2016
// ------------------------------------------------------------------------------


C_TEXT:C284($1)  // Report file path (include file name)      

// Record type: "1B"
C_TEXT:C284($2)

// Sub-header sequence number
C_LONGINT:C283($3)

// Reporting entity report group ID
// This can be any value you choose to identify the grouping of the reports included in the batch. If you do not use this value, space-fill this field
C_TEXT:C284($4)

// Report count
// Enter the total number of reports included for the sub-header 
C_LONGINT:C283($5)

C_BLOB:C604($content)

C_TEXT:C284($recordType; $seqNumber; $reportGroupId; $numOfReports)
// Record type: Constant "1B"
$recordType:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($recordType; $content; UTF8 text without length:K22:17; *)

// Sub-header sequence number
$seqNumber:=FT_NumberFormat($3; 0; 5; "0"; "RJ")
TEXT TO BLOB:C554($seqNumber; $content; UTF8 text without length:K22:17; *)

// Reporting entity report group ID
$reportGroupId:=FT_StringFormat($4; 25; " "; "LJ")
TEXT TO BLOB:C554($reportGroupId; $content; UTF8 text without length:K22:17; *)

//  total number of reports included for the sub-header 
$numOfReports:=FT_NumberFormat($5; 0; 5; "0"; "RJ")
TEXT TO BLOB:C554("_RS??"; $content; UTF8 text without length:K22:17; *)
//TEXT TO BLOB($numOfReports;$content;UTF8 text without length;*)

AppendBlobToFile($1; $content)







