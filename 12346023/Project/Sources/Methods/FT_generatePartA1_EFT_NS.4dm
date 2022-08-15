//%attributes = {}
// FT_generatePartA1_EFT_NS
// Generate information about Part A1: Information about where the transaction took place

C_TEXT:C284($1; $fileName; $3; $batchSeqId)
C_LONGINT:C283($2; $txIdx; $4; $i)
C_BOOLEAN:C305($5; $isRelatedIran)
Case of 
	: (Count parameters:C259=5)
		$fileName:=$1
		$txIdx:=$2
		$batchSeqId:=$3
		$i:=$4
		$isRelatedIran:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($repSeqNum)
C_TEXT:C284($partId; $repEntityRefNum; $actionCode; $timeTx; $dateTx; $amountTx; $rule24Indicator)
C_TEXT:C284($txCurrency; $exchangeRate)
C_BOOLEAN:C305(underThreshold)
underThreshold:=False:C215


// -----------------------------------------------------------------------------------------------------------------
// Part A: Information about where the transaction took place
// This part is for information about you, the reporting entity required to report 
// the transaction to FINTRAC. It is also for information about the physical location 
// where the transaction took place or was attempted. 
// -----------------------------------------------------------------------------------------------------------------

$partId:="A1"  // Part ID

// Report sequence number within the preceding sub-header
$repSeqNum:=$txIdx

$repEntityRefNum:=$batchSeqId

//If ($isRelatedIran)
//$repEntityRefNum:=FT_StringFormat ("IR2020"+$batchSeqId+"E";20;" ";"LJ")
//Else 
//$repEntityRefNum:=FT_StringFormat ($batchSeqId+"E";20;" ";"LJ")
//End if 

// A unique report reference number
//$repEntityRefNum:="R"+FT_NumberFormat ($batchSeqId;0;19;"0";"RJ")

// We are Submitting a new batch (type "A"), To change a report  (type "C"), delete a report (type "D")
$actionCode:="A"  // Is a new Batch


// 24-hour rule indicator
$rule24Indicator:="0"

If ($i<=Size of array:C274(arr24HoursIndicator))
	If (arr24HoursIndicator{$i})
		$rule24Indicator:="1"
	Else 
		$rule24Indicator:="0"
	End if 
End if 

// Part A: Information about where the transaction took place (Write A1 Part)
FT_PartA_EFT_NS($fileName; $partId; $repSeqNum; $repEntityRefNum; $actionCode; [Invoices:5]CreationTime:14; [Wires:8]WireTransferDate:17; [Wires:8]Amount:14; $rule24Indicator; [Wires:8]Currency:15; [Wires:8]OurRate:21)

