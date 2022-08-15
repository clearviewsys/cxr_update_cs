//%attributes = {}


// ------------------------------------------------------------------------------
// Method: FT_Header1A : 
// It Is the batch header that contains information identifying the individual 
// or institution originating the transmission. 
// There can be only one batch header for each transmitted file. 
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/21/2015
// ------------------------------------------------------------------------------


C_TEXT:C284($1)  // Report file path (include file name)      


C_TEXT:C284($2)  // Record type
C_TEXT:C284($3)  // Code format
C_TEXT:C284($4)  // Report type

C_TEXT:C284($5)  // Reporting entity’s identifier number

C_TEXT:C284($6)  // Contact's surname
C_TEXT:C284($7)  // Contact's given name
C_TEXT:C284($8)  // Contact person telephone number
C_TEXT:C284($9)  // Contact person telephone extension number

C_TEXT:C284($10)  // PKI certificate ID
C_TEXT:C284($11)  // Batch date
C_TEXT:C284($12)  // Batch Time
C_LONGINT:C283($13)  // Batch sequence ID

C_TEXT:C284($14)  // Batch type
C_LONGINT:C283($15)  // Sub-header count
C_LONGINT:C283($16)  // Report count
C_TEXT:C284($17)  // Format indicator “03” for LCTR
C_TEXT:C284($18)  // Operational mode “P” – Production “T” – Test


C_BLOB:C604($content)
C_TEXT:C284($recordType; $codeFormat; $reportType; $repEntityIdNum; $contactSurName; $contactGivenName; $contactPhoneNumber)
C_TEXT:C284($contactPhoneNumberExt; $pkiCertificateId; $batchDate; $batchTime; $batchSeqId; $batchType; $formatIndicator; $opMode)

// Record type
$recordType:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($recordType; $content; UTF8 text without length:K22:17; *)

// Code format
$codeFormat:=FT_StringFormat($3; 3)
TEXT TO BLOB:C554($codeFormat; $content; UTF8 text without length:K22:17; *)

// Report type
$reportType:=FT_StringFormat($4; 4; " "; "LJ")
TEXT TO BLOB:C554($reportType; $content; UTF8 text without length:K22:17; *)

// Reporting entity's identifier number
$repEntityIdNum:=FT_StringFormat($5; 7; "0"; "RJ")
TEXT TO BLOB:C554($repEntityIdNum; $content; UTF8 text without length:K22:17; *)


// Contact's surname
$contactSurName:=FT_StringFormat($6; 20; " "; "LJ")
TEXT TO BLOB:C554($contactSurName; $content; UTF8 text without length:K22:17; *)

// Contact's given name
$contactGivenName:=FT_StringFormat($7; 15; " "; "LJ")
TEXT TO BLOB:C554($contactGivenName; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------
// Contact person telephone number
$contactPhoneNumber:=FT_StringFormat($8; 20; " "; "LJ")
TEXT TO BLOB:C554($contactPhoneNumber; $content; UTF8 text without length:K22:17; *)

// Contact person telephone extension number TODO: Format using "-"
$contactPhoneNumberExt:=FT_StringFormat($9; 5; "0"; "RJ")
TEXT TO BLOB:C554($contactPhoneNumberExt; $content; UTF8 text without length:K22:17; *)

// PKI certificate ID
$pkiCertificateId:=FT_StringFormat($10; 10; "0"; "RJ")
TEXT TO BLOB:C554($pkiCertificateId; $content; UTF8 text without length:K22:17; *)

// Batch Date
$batchDate:=FT_StringFormat($11; 8; "0"; "LJ")
TEXT TO BLOB:C554($batchDate; $content; UTF8 text without length:K22:17; *)

// Batch Time
$batchTime:=FT_StringFormat($12; 6; "0"; "LJ")
TEXT TO BLOB:C554($batchTime; $content; UTF8 text without length:K22:17; *)

// Batch sequence ID
$batchSeqId:=FT_NumberFormat($13; 0; 5; "0"; "RJ")
TEXT TO BLOB:C554($batchSeqId; $content; UTF8 text without length:K22:17; *)

// Batch Type
$batchType:=FT_StringFormat($14; 1; " "; "LJ")
TEXT TO BLOB:C554($batchType; $content; UTF8 text without length:K22:17; *)

// Sub-header count
//$subHeaderCnt:=FT_NumberFormat ($15;0;5;"0";"RJ")
TEXT TO BLOB:C554("_SH??"; $content; UTF8 text without length:K22:17; *)

// Report count
//$reportCnt:=FT_NumberFormat ($16;0;5;"0";"RJ")

//TEXT TO BLOB($reportCnt;$content;UTF8 text without length;*)
TEXT TO BLOB:C554("_RC??"; $content; UTF8 text without length:K22:17; *)


// Format indicator
$formatIndicator:=FT_StringFormat($17; 2; "0"; "RJ")
TEXT TO BLOB:C554($formatIndicator; $content; UTF8 text without length:K22:17; *)

// Operational mode
$opMode:=FT_StringFormat($18; 1; " "; "LJ")
TEXT TO BLOB:C554($opMode; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($1; $content)







