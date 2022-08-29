//%attributes = {}
// FT_generatePartA1_EFT
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

// A unique report reference number
//$repEntityRefNum:="R"+FT_NumberFormat ($batchSeqId;0;19;"0";"RJ")
//$repEntityRefNum:=FT_StringFormat ("E"+$batchSeqId;20;" ";"LJ")
$repEntityRefNum:=$batchSeqId

// We are Submitting a new batch (type "A"), To change a report  (type "C"), delete a report (type "D")
$actionCode:="A"  // Is a new Batch


// 24-hour rule indicator
$rule24Indicator:="0"

// --------------------------------------------------
// Set 24 hours indicator for all the invoices.
// --------------------------------------------------
C_TEXT:C284($queryType)
$queryType:=getKeyValue("FT.UseAMLRules"; "0")
Case of 
		
	: ($queryType="0")  // By Default: Do not use the AML Agr Rules
		
		
		If (arr24HoursIndicator{$i})
			$rule24Indicator:="1"
		Else 
			$rule24Indicator:="0"
		End if 
		
	: ($queryType="1")
		
		If (Position:C15("24H"; [Invoices:5]AMLReportName:75)>0)
			$rule24Indicator:="1"
		Else 
			$rule24Indicator:="0"
		End if 
End case 




// Part A: Information about where the transaction took place (Write A1 Part)
If ([eWires:13]isPaymentSent:20)
	FT_partA_EFT($fileName; $partId; $repSeqNum; $repEntityRefNum; $actionCode; [eWires:13]creationTime:54; [eWires:13]creationDate:53; [eWires:13]ToAmount:14; $rule24Indicator; [eWires:13]Currency:12; [eWires:13]sourceRate:41)
Else 
	FT_partA_EFT($fileName; $partId; $repSeqNum; $repEntityRefNum; $actionCode; [eWires:13]creationTime:54; [eWires:13]creationDate:53; [eWires:13]FromAmount:13; $rule24Indicator; [eWires:13]Currency:12; [eWires:13]sourceRate:41)
End if 

