//%attributes = {}
// FT_GenerateHeader1A_EFTI
// Generate Header 1A for reporting to FINTRAC

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
C_TEXT:C284($recordType; $codeFormat; $reportType; $reportingEntityName; $reportingEntityPKI)
C_TEXT:C284($reportingEntityCertificateID; $reportingEntityLocationNumber; $contactSurName)
C_TEXT:C284($contactGivenName; $contactOtherName; $contactPhoneNumberExt; $reportGroupId)
C_TEXT:C284($currentDate; $currentTime; $batchDate; $batchTime; $opMode; $batchType; $formatIndicator; $contactPhoneNumber)
C_LONGINT:C283($subHeaderCnt)


// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------

// Record type
$recordType:="1A"

// Code format
$codeFormat:="850"

// Report type
$reportType:="EFTI"

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
$batchType:="A"  // Add a new Report

// Sub-header count: Number of sub-headers in the batch 
$subHeaderCnt:=1

// Report count: How many reports in file? A1 Parts
//$reportCnt:=Size of array(arrFTCustomerID)

// Format indicator
$formatIndicator:="03"  // 


// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------

//FT_Header1A ($fileName;$recordType;$codeFormat;$reportType;reportingEntityCertificateID;contactSurName;contactGivenName;contactPhoneNumber;contactPhoneNumberExt;reportingEntityPKI;$batchDate;$batchTime;$batchSeqId;$batchType;$subHeaderCnt;$reportCnt;$formatIndicator;$opMode)
FT_Header1A($fileName; $recordType; $codeFormat; $reportType; reportingEntityCertificateID; contactSurName; contactGivenName; contactPhoneNumber; contactPhoneNumberExt; reportingEntityPKI; $batchDate; $batchTime; $batchSeqId; $batchType; $subHeaderCnt; $reportCnt; $formatIndicator; $opMode)

