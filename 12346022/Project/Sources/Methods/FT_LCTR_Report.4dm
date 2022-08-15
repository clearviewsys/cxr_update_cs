//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FT_LCTR_REPORT
// Generate the LCTR Report for FINTRAC
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 4/27/2016
// ------------------------------------------------------------------------------



ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)

C_TIME:C306($vhDoc)
C_TEXT:C284($iniFile)
C_LONGINT:C283($batchSeqId)
C_BLOB:C604($blobReport)


// $batchSeqId: This is a numeric sequence identifier created by you for the batch. 
// The combination of batch date, time and sequence identifier must be unique for each of your batches. 
// For example, if you were to send two batches in a day, use 00001 for the first batch sequence identifier and 
// 00002 for the second.
C_TEXT:C284($fileName; $msg)

$batchSeqId:=1

// Get all transactions in the date range
//FT_Get_LCTR_Transactions 

// Create and define the LCTR Report File Name
$fileName:=FT_GetFileName

// Validate Report parameters
checkInit
checkAddErrorIf($fileName=""; "You must select a Folder to save the report")



If (isValidationConfirmed)
	
	FT_GenerateLCTRReport2($fileName; (operationMode=0))
	
	QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; arrFTRegisterID)
	ORDER BY:C49([Registers:10]; [Registers:10]CreationDate:14; >; [Registers:10]CreationTime:15; >)
	
	If (Test path name:C476($fileName)=Is a document:K24:1)
		DOCUMENT TO BLOB:C525($fileName; $blobReport)
		xmlFile:=BLOB to text:C555($blobReport; UTF8 text without length:K22:17)
		FORM GOTO PAGE:C247(6)
		setKeyValue("fintrac.last.report.date"; String:C10(initialDate))
	Else 
		
		$msg:="There are not transactions that can be reported as LCTR in the date range requested"
		myAlert($msg)
		
		
	End if 
	
End if 





