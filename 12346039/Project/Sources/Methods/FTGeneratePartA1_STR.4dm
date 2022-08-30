//%attributes = {}
// FTGeneratePartA1_STR
// Generate information about Part A1: Information about where the transaction took place

C_TEXT:C284($1; $fileName)
C_LONGINT:C283($2; $a1seq; $3; $batchSeqId; $4; $i)

Case of 
	: (Count parameters:C259=4)
		$fileName:=$1
		$a1seq:=$2
		$batchSeqId:=$3
		$i:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
// -----------------------------------------------------------------------------------------------------------------
// Part A: Information about where the transaction took place
// This part is for information about you, the reporting entity required to report 
// the transaction to FINTRAC. It is also for information about the physical location 
// where the transaction took place or was attempted. 
// -----------------------------------------------------------------------------------------------------------------
C_LONGINT:C283($repSeqNum)
C_TEXT:C284($partID; $repEntityRefNum; $actionCode)

$partId:="A1"  // Part ID

// Report sequence number within the preceding sub-header
$repSeqNum:=$a1seq

// A unique report reference number
$repEntityRefNum:="R"+FT_NumberFormat($batchSeqId; 0; 19; "0"; "RJ")

$actionCode:="A"
// Part A: Information about where the transaction took place (Write A1 Part)

FT_PartA($fileName; $partId; $repSeqNum; $repEntityRefNum; $actionCode; reportingEntityCertificateID; [Branches:70]LocationNumberFT:19; contactSurName; contactGivenName; contactOtherName; contactPhoneNumber; contactPhoneNumberExt; "K"; "1")
