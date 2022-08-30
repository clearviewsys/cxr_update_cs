//%attributes = {}
// FT_GenerateHeader1A_EFT
// Generate Header 1A for reporting EFT to FINTRAC

C_TEXT:C284($filename; $1)
C_LONGINT:C283($2; $batchSeqId)
C_LONGINT:C283($3; $reportCnt)


Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$batchSeqId:=$2  // Batch Sequence ID
		$reportCnt:=Size of array:C274(arrFTCustomerID)
		
	: (Count parameters:C259=3)
		$fileName:=$1
		$batchSeqId:=$2  // Batch Sequence ID
		$reportCnt:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($recordType; $codeFormat; $reportType; $contactSurName; $contactGivenName; $contactPhoneNumber; $contactPhoneNumberExt; $pkiCertificateId)
C_TEXT:C284($batchTime; $batchType; $formatIndicator; $opMode)

// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------

// Record type
$recordType:="A1"

// Code format
$codeFormat:="850"

// Report type
$reportType:="EFTO"

// Reporting entity Name 
C_TEXT:C284($reportingEntityName)
$reportingEntityName:=reportingEntityName

// PKI certificate ID (Given by FINTRAC)S
C_TEXT:C284($reportingEntityPKI)
$reportingEntityPKI:=reportingEntityPKI

// Reporting entity's identifier number (Given by FINTRAC)
C_TEXT:C284($reportingEntityCertificateID)
$reportingEntityCertificateID:=reportingEntityCertificateID

// Reporting entity Location Number (Given by FINTRAC)
C_TEXT:C284($reportingEntityLocationNumber)
$reportingEntityLocationNumber:=reportingEntityLocationNumber

// Contact's surname
$contactSurName:=contactSurName

// Contact's given name
$contactGivenName:=contactGivenName

// Contact's Other name/Initial
C_TEXT:C284($contactOtherName)
$contactOtherName:=contactOtherName

// Contact person telephone number
C_TEXT:C284($contactPhoneNumber)
$contactPhoneNumber:=contactPhoneNumber

// Contact person telephone extension number 
$contactPhoneNumberExt:=contactPhoneNumberExt



// Report Group ID 
C_TEXT:C284($reportGroupId; $currentDate; $currentTime)
$reportGroupId:=reportingEntityLocationName

// Set Current date and Time (string)
$currentDate:=FT_GetStringDate  // YYYYMMDD
$currentTime:=FT_GetStringTime  // HHMMSS


// Date of report
C_TEXT:C284($batchDate)
$batchDate:=$currentDate

// Time of report
C_TEXT:C284($batchTime)
$batchTime:=$currentTime


C_TEXT:C284($opMode)
//Operational mode: T-Test/P-Production
If (operationMode=1)  // Declared  the FINTRAC Report main Form
	$opMode:="T"
Else 
	$opMode:="P"
End if 

// Batch Type
C_TEXT:C284($batchType)
$batchType:="A"  // Add a new Report

// Sub-header count: Number of sub-headers in the batch 
C_LONGINT:C283($subHeaderCnt)
$subHeaderCnt:=1

// Report count: How many reports in file? A1 Parts
//$reportCnt:=Size of array(arrFTCustomerID)

// Format indicator
C_TEXT:C284($formatIndicator)
$formatIndicator:="03"  // LCTR

// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------

FT_Header1A_EFT($fileName; $recordType; $codeFormat; $reportType; reportingEntityCertificateID; contactSurName; contactGivenName; contactPhoneNumber; contactPhoneNumberExt; reportingEntityPKI; $batchDate; $batchTime; $batchSeqId; $batchType; $subHeaderCnt; $reportCnt; $formatIndicator; $opMode)

