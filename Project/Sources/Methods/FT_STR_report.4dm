//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FT_STR_Report
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 5/19/2019
// ------------------------------------------------------------------------------



ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)

C_TIME:C306($vhDoc)
C_TEXT:C284($iniFile; $msg)
C_LONGINT:C283($batchSeqId)

$msg:="Remember to generate the STR report you must mark the invoice as STR and create the report using the option AML Reports informing the suspicious activity and the action taken. "
myAlert($msg)

// $batchSeqId: This is a numeric sequence identifier created by you for the batch. 
// The combination of batch date, time and sequence identifier must be unique for each of your batches. 
// For example, if you were to send two batches in a day, use 00001 for the first batch sequence identifier and 
// 00002 for the second.

$batchSeqId:=1

// Get all transactions in the date range
//FT_Get_LCTR_Transactions 
FT_Get_STR_Transactions(initialDate)



// Create and define the LCTR Report File Name
C_TEXT:C284($fileName; $msg)
C_BLOB:C604($blobReport)

$fileName:=FT_GetFileName("_STR")

// Validate Report parameters
checkInit
checkAddErrorIf($fileName=""; "You must select a Folder to save the report")

If (Records in selection:C76([AML_Reports:119])=0)
	$msg:="There are not transactions that can be reported as STR in the date requested"
	
	checkAddError($msg)
End if 

If (isValidationConfirmed)
	FT_GenerateSTRReport($fileName)
	
	DOCUMENT TO BLOB:C525($fileName; $blobReport)
	xmlFile:=BLOB to text:C555($blobReport; UTF8 text without length:K22:17)
	FORM GOTO PAGE:C247(7)
Else 
	C_LONGINT:C283($compressed; $expandedSize; $currentSize)
	If (Test path name:C476($fileName)=Is a document:K24:1)
		DOCUMENT TO BLOB:C525($fileName; $blobReport)
		BLOB PROPERTIES:C536($blobReport; $compressed; $expandedSize; $currentSize)
		If ($currentSize=0)
			DELETE DOCUMENT:C159($fileName)
		End if 
	End if 
	
End if 

