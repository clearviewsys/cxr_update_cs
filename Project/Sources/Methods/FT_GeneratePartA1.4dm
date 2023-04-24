//%attributes = {}
// FT_generatePartA1
// Generate information about Part A1: Information about where the transaction took place

C_TEXT:C284($1; $fileName; $3; $batchSeqId)
C_LONGINT:C283($2; $a1seq; $4; $i; $p)
C_BOOLEAN:C305($5; $isRelatedIran)
C_REAL:C285($amount)

Case of 
	: (Count parameters:C259=5)
		$fileName:=$1
		$a1seq:=$2
		$batchSeqId:=$3
		$i:=$4
		$isRelatedIran:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
// -----------------------------------------------------------------------------------------------------------------
// Part A: Information about where the transaction took place
// This part is for information about you, the reporting entity required to report 
// the transaction to FINTRAC. It is also for information about the physical location 
// where the transaction took place or was attempted. 
// -----------------------------------------------------------------------------------------------------------------
C_TEXT:C284($partId; $repEntityRefNum; $actionCode; $entityType; $rule24Indicator; $rule24Indicator)
C_LONGINT:C283($repSeqNum)

$partId:="A1"  // Part ID


// Report sequence number within the preceding sub-header
$repSeqNum:=$a1seq

// A unique report reference number
$repEntityRefNum:=$batchSeqId
//$repEntityRefNum:="R"+FT_NumberFormat ($batchSeqId;0;19;"0";"RJ")
//$repEntityRefNum:=FT_NumberFormat ($batchSeqId;0;20;"0";"RJ")
//If ($isRelatedIran)
//$repEntityRefNum:=FT_StringFormat ("IR2020"+$batchSeqId+"L";20;" ";"LJ")
//Else 
//$repEntityRefNum:=FT_StringFormat ($batchSeqId+"L";20;" ";"LJ")
//End if 


// We are Submitting a new batch (type "A"), To change a report  (type "C"), delete a report (type "D")
$actionCode:="A"  // Is a new Batch

// Type of reporting entity
$entityType:="K"  // K-Money services business

// 24-hour rule indicator
$rule24Indicator:="0"

$p:=Find in array:C230(arrInvoicesFT; [Invoices:5]InvoiceID:1)
If ($p>0)
	If (arr24HourIndicator{$p})
		$rule24Indicator:="1"
	Else 
		$rule24Indicator:="0"
	End if 
Else 
	// Not possible it must exist on array arrInvoicesFT
End if 


// --------------------------------------------------
C_TEXT:C284($queryType)

$queryType:=getKeyValue("FT.UseAMLRules"; "0")


If ($queryType="0")  // By Default: Do not use the AML Agr Rules
	
	If ([Registers:10]RegisterType:4="Buy")
		$amount:=AmountToSpotRate([Registers:10]DebitLocal:23)
	Else 
		$amount:=AmountToSpotRate([Registers:10]CreditLocal:24)
	End if 
	
	
	If ([Registers:10]Currency:19=getKeyValue("TOMCode"; "TOM"))
		$amount:=$amount*10  // Convert to IRR (1 Toman = 10 IRR)
	End if 
	
	
	If (($amount<[ServerPrefs:27]twoIDsLimit:15) & (Not:C34($isRelatedIran)))
		$rule24Indicator:="1"
	End if 
	
End if 

// Part A: Information about where the transaction took place (Write A1 Part)
FT_PartA($fileName; $partId; $repSeqNum; $repEntityRefNum; $actionCode; reportingEntityCertificateID; [Branches:70]LocationNumberFT:19; contactSurName; contactGivenName; contactOtherName; contactPhoneNumber; contactPhoneNumberExt; $entityType; $rule24Indicator)
