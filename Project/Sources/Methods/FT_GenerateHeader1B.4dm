//%attributes = {}

// FT_GenerateHeader1B
// Generate the sub-header 1B

C_TEXT:C284($1; $fileName)
C_LONGINT:C283($2; $numReports; $3; $subSeq)
C_TEXT:C284($4; $reportGroupId)

$reportGroupId:=reportingEntityLocationName

Case of 
		
	: (Count parameters:C259=1)
		$fileName:=$1
		$numReports:=Size of array:C274(arrFTCustomerId)
		$subSeq:=1
		
	: (Count parameters:C259=2)
		$fileName:=$1
		$numReports:=$2
		$subSeq:=1
		
	: (Count parameters:C259=3)
		$fileName:=$1
		$numReports:=$2
		$subSeq:=$3
		
		
	: (Count parameters:C259=4)
		$fileName:=$1
		$numReports:=$2
		$subSeq:=$3
		$reportGroupId:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// ----------------------------------------------------------------------------------------
// Begin SubHeader1B
// ----------------------------------------------------------------------------------------

// FT_SubHeader1B : 
// The batch sub-header contains information that allows you to group reports 
// included in the batch according to your organizational structure or any other 
// grouping need. The use of different sub-headers is optional, but you must include 
// at least one sub-header in a batch. 
C_TEXT:C284($recordType)
// Record type: Constant "1B"
$recordType:="1B"

// Sub-header sequence number
//$subSeq:=1

// Reporting entity report group ID
// Taken from parameters


//  total number of reports included for the sub-header 
// $numReports:=Size of array(arrFTCustomerId)

FT_Subheader1B($fileName; $recordType; $subSeq; $reportGroupId; $numReports)
