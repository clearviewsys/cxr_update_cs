//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FT_DeleteLCTRReport
// Generate the File to delete a report sent to FINTRAC
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 4/27/2016
// ------------------------------------------------------------------------------
C_TEXT:C284($1; $fileName)
C_LONGINT:C283($2; $reportSeq)


ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_LONGINT:C283($batchSeqId)
C_BLOB:C604($content)


Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$reportSeq:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Get Next batch sequence
$batchSeqId:=FT_NextSequence("LCTR_BatchSeq")

// Get the config information from the fintrac.ini saved in the active 4D Database Folder
FT_GetEntityAndContactInfo

// Write the headers report

// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------
FT_GenerateHeader1A($fileName; $batchSeqId; "LCTR"; 1)

// ---------------------------------------------------------------------------------------------------------
// The batch sub-header contains information that allows you to group reports 
// included in the batch according to your organizational structure or any other 
// grouping need. The use of different sub-headers is optional, but you must include 
// at least one sub-header in a batch. 
// ---------------------------------------------------------------------------------------------------------

FT_GenerateHeader1B($fileName; 1)



// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------

C_TEXT:C284($partId; $repSeqNum; $repEntityRefNum; $actionCode; $repEntityIdNum; $footer)
C_BLOB:C604($content)

$partId:="A1"
$repSeqNum:=FT_NumberFormat($reportSeq; 0; 5; "0"; "RJ")
$repEntityRefNum:="R"+FT_NumberFormat($reportSeq; 0; 19; "0"; "RJ")  // A unique report reference number
$actionCode:="D"
$repEntityIdNum:=reportingEntityCertificateID

CLEAR VARIABLE:C89($content)

// Part ID
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Report sequence number
TEXT TO BLOB:C554($repSeqNum; $content; UTF8 text without length:K22:17; *)

// Reporting entity's identifier number
TEXT TO BLOB:C554($repEntityRefNum; $content; UTF8 text without length:K22:17; *)

// Action code
TEXT TO BLOB:C554($actionCode; $content; UTF8 text without length:K22:17; *)

// Reporting entity's identifier number
TEXT TO BLOB:C554($repEntityIdNum; $content; UTF8 text without length:K22:17; *)

// Reporting entity's identifier number
TEXT TO BLOB:C554(Char:C90(CR ASCII code:K15:14); $content; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(Char:C90(LF ASCII code:K15:11); $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($fileName; $content)

// --------------------- FOOTER -----------------------------

CLEAR VARIABLE:C89($content)
$footer:="1C00001"
TEXT TO BLOB:C554($footer; $content; UTF8 text without length:K22:17; *)
AppendBlobToFile($fileName; $content)


