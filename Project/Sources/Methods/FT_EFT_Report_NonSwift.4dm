//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FT_EFT_report_NonSwift
// Generate the EFTO Report for FINTRAC
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 4/27/2019
// ------------------------------------------------------------------------------

C_BOOLEAN:C305($1; $isOutgoing)
Case of 
	: (Count parameters:C259=1)
		$isOutgoing:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

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
FT_Get_EFT_Transactions_NS(initialDate; initialDate; $isOutgoing)



// Create and define the LCTR Report File Name
If ($isOutgoing)
	$fileName:=FT_GetFileName("_EFTO")
Else 
	$fileName:=FT_GetFileName("_EFTI")
End if 

// Validate Report parameters
checkInit
checkAddErrorIf($fileName=""; "You must select a Folder to save the report")

If (Records in selection:C76([Wires:8])=0)
	If ($isOutgoing)
		$msg:="There are not transactions that can be reported as Wires EFTO in the date requested"
	Else 
		$msg:="There are not transactions that can be reported as Wires EFTI in the date requested"
	End if 
	
	
	checkAddError($msg)
End if 

If (isValidationConfirmed)
	If ($isOutgoing)
		FT_GenerateEFTOReport_NonSwift($fileName)
	Else 
		FT_GenerateEFTIReport_NonSwift($fileName)
	End if 
	
	
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


