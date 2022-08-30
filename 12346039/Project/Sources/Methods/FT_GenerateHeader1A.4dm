//%attributes = {}
// FT_GenerateHeader1A ($filename;$batchSeqId;$reportType;{$reportCnt;$isNewReport})
// Generate Header 1A for reporting to FINTRAC

C_TEXT:C284($filename; $1)
C_TEXT:C284($3; $reportType)
C_LONGINT:C283($2; $batchSeqId)

C_LONGINT:C283($4; $reportCnt)
C_BOOLEAN:C305($5; $isNewReport)

Case of 
		
	: (Count parameters:C259=3)
		
		$fileName:=$1
		$batchSeqId:=$2  // Batch Sequence ID
		$reportType:=$3
		$reportCnt:=Size of array:C274(arrFTCustomerID)
		$isNewReport:=True:C214
		
	: (Count parameters:C259=4)
		
		$fileName:=$1
		$batchSeqId:=$2  // Batch Sequence ID
		$reportType:=$3
		$reportCnt:=$4
		$isNewReport:=True:C214
		
	: (Count parameters:C259=5)
		
		$fileName:=$1
		$batchSeqId:=$2  // Batch Sequence ID
		$reportType:=$3
		$reportCnt:=$4
		$isNewReport:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------

C_TEXT:C284($recordType; $codeFormat; $reportingEntityName; $reportingEntityPKI; $reportingEntityCertificateID; $reportingEntityLocationNumber; $contactSurName; $contactGivenName)
C_TEXT:C284($contactOtherName; $contactPhoneNumber; $contactPhoneNumberExt; $reportGroupId; $opMode; $batchType; $formatIndicator)
C_TEXT:C284($currentDate; $batchDate; $batchTime; $currentTime)
C_LONGINT:C283($subHeaderCnt)

// Record type
$recordType:="1A"

// Code format
$codeFormat:="850"

// Report type
//$reportType:="LCTR"

// Reporting entity Name 
$reportingEntityName:=reportingEntityName

// PKI certificate ID (Given by FINTRAC)S
$reportingEntityPKI:=reportingEntityPKI

// Reporting entity's identifier number (Given by FINTRAC)
$reportingEntityCertificateID:=reportingEntityCertificateID

// Reporting entity Location Number (Given by FINTRAC)
$reportingEntityLocationNumber:=reportingEntityLocationNumber

// Contact's surname
$contactSurName:=contactSurName

// Contact's given name
$contactGivenName:=contactGivenName

// Contact's Other name/Initial
$contactOtherName:=contactOtherName

// Contact person telephone number
$contactPhoneNumber:=contactPhoneNumber

// Contact person telephone extension number 
$contactPhoneNumberExt:=contactPhoneNumberExt


// Report Group ID 
$reportGroupId:=reportingEntityLocationName

// Set Current date and Time (string)
$currentDate:=FT_GetStringDate  // YYYYMMDD
$currentTime:=FT_GetStringTime  // HHMMSS

// Date of report
$batchDate:=$currentDate

// Time of report
$batchTime:=$currentTime

//Operational mode: T-Test/P-Production
If (operationMode=1)  // Declared  the FINTRAC Report main Form
	$opMode:="T"
Else 
	$opMode:="P"
End if 

// Batch Type
If ($isNewReport)
	$batchType:="A"  // Add a new Report
Else 
	$batchType:="C"  // Delete or change report
End if 


// Sub-header count: Number of sub-headers in the batch 
$subHeaderCnt:=1  // SET Number of Branches or subheaders

// Report count: How many reports in file? A1 Parts
//$reportCnt:=Size of array(arrFTCustomerID)

// Format indicator
If ($reportType#"STR ")
	$formatIndicator:="03"  // LCTR, EFTO, EFTI
Else 
	$formatIndicator:="04"  // Onl for STR report
End if 


// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------

//FT_Header1A ($fileName;$recordType;$codeFormat;$reportType;reportingEntityCertificateID;contactSurName;contactGivenName;contactPhoneNumber;contactPhoneNumberExt;reportingEntityPKI;$batchDate;$batchTime;$batchSeqId;$batchType;$subHeaderCnt;$reportCnt;$formatIndicator;$opMode)
FT_Header1A($fileName; $recordType; $codeFormat; $reportType; reportingEntityCertificateID; contactSurName; contactGivenName; contactPhoneNumber; contactPhoneNumberExt; reportingEntityPKI; $batchDate; $batchTime; $batchSeqId; $batchType; $subHeaderCnt; $reportCnt; $formatIndicator; $opMode)

