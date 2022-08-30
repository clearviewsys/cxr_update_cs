//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FT_EFTO_report
// Generate the EFTO Report for FINTRAC
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 4/27/2019
// ------------------------------------------------------------------------------



ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)

C_TIME:C306($vhDoc)
C_TEXT:C284($iniFile; $fileName; $msg)
C_LONGINT:C283($batchSeqId)
C_BLOB:C604($blobReport)


// $batchSeqId: This is a numeric sequence identifier created by you for the batch. 
// The combination of batch date, time and sequence identifier must be unique for each of your batches. 
// For example, if you were to send two batches in a day, use 00001 for the first batch sequence identifier and 
// 00002 for the second.

$batchSeqId:=1

// Get all transactions in the date range
//FT_Get_LCTR_Transactions 
FT_Get_EFTO_Transactions(initialDate)



// Create and define the LCTR Report File Name
$fileName:=FT_GetFileName("_EFTO")

// Validate Report parameters
checkInit
checkAddErrorIf($fileName=""; "You must select a Folder to save the report")

If (Records in selection:C76([eWires:13])=0)
	$msg:="There are not transactions that can be reported as EFTO in the date requested"
	
	checkAddError($msg)
End if 

If (isValidationConfirmed)
	FT_GenerateEFTOReport($fileName)
	
	DOCUMENT TO BLOB:C525($fileName; $blobReport)
	xmlFile:=BLOB to text:C555($blobReport; UTF8 text without length:K22:17)
	FORM GOTO PAGE:C247(7)
Else 
	C_LONGINT:C283($compressed; $expandedSize; $currentSize)
	DOCUMENT TO BLOB:C525($fileName; $blobReport)
	BLOB PROPERTIES:C536($blobReport; $compressed; $expandedSize; $currentSize)
	If ($currentSize=0)
		DELETE DOCUMENT:C159($fileName)
	End if 
	
End if 


