//%attributes = {}
// createRegisterofEWire ($isInInvoice)


C_POINTER:C301($tablePtr)
C_TEXT:C284($extRef; $invoiceID; $registerId; $accountID; $subAccountID; $referenceNo)
C_REAL:C285($amount)
C_TEXT:C284($currency)
C_BOOLEAN:C305($isReceived)
C_DATE:C307($issueDate; $dueDate)
C_POINTER:C301($autoCMTPtr)
C_REAL:C285($pctFee; $feeLocal; $ourRate; $spotRate)
C_TEXT:C284($customerID)
C_REAL:C285($amountLocal)
C_TEXT:C284($branchID; $userID)

C_BOOLEAN:C305($isTransfer)
C_TEXT:C284($currencyAlias)
C_REAL:C285($boardBuyRate; $boardSellRate)

C_BOOLEAN:C305($isOfflineMethod; $1)

If (Count parameters:C259=1)
	$isOfflineMethod:=$1
Else 
	$isOfflineMethod:=False:C215
End if 


$tablePtr:=->[eWires:13]
$extRef:=[eWires:13]eWireID:1
If ([eWires:13]InvoiceNumber:29#"")
	$invoiceID:=[eWires:13]InvoiceNumber:29
Else 
	$invoiceID:="N/A"
End if 

$registerId:=[eWires:13]RegisterID:24
$accountID:=[eWires:13]AccountID:30
$referenceNo:=[eWires:13]ReferenceNo:28

$amount:=[eWires:13]FromAmount:13
$currency:=[eWires:13]FromCurrency:11
$isReceived:=Not:C34([eWires:13]isPaymentSent:20)

$customerID:=[eWires:13]CustomerID:15
$autoCMTPtr:=->[eWires:13]Subject:6
$dueDate:=[eWires:13]SendDate:2
$issueDate:=[eWires:13]SendDate:2
$subAccountID:=[eWires:13]SubAccountID:118

Case of 
		
	: ([eWires:13]isPaymentSent:20)
		
		$amount:=[eWires:13]ToAmount:14
		$currency:=[eWires:13]Currency:12
		
		$pctFee:=[eWires:13]sourcePCTFee:43
		$feeLocal:=[eWires:13]sourceServicefeeLocal:44
		$ourRate:=[eWires:13]sourceRate:41
		$spotRate:=[eWires:13]sourceSpotRate:42
		$amountLocal:=[eWires:13]amountLocal:45
		
	Else   //  Payment Received
		
		$amount:=[eWires:13]FromAmount:13
		$currency:=[eWires:13]FromCurrency:11  // changed tom fromCurrency 
		
		If ($isOfflineMethod)
			$pctFee:=[eWires:13]sourcePCTFee:43
			$feeLocal:=[eWires:13]sourceServicefeeLocal:44
			$ourRate:=[eWires:13]sourceRate:41
			$spotRate:=[eWires:13]sourceSpotRate:42
			$amountLocal:=[eWires:13]amountLocal:45
		Else 
			$pctFee:=[eWires:13]destinationPctFee:90
			$feeLocal:=[eWires:13]DestinationServiceFee:21
			$ourRate:=[eWires:13]destinationRate:87
			$spotRate:=[eWires:13]destinationSpotRate:89
			$amountLocal:=[eWires:13]destinationAmountLocal:88
		End if 
End case 


[eWires:13]Subject:6:=makeCommentseWire
//[eWires]RegisterID:=createRegisterFromTable ($tablePtr;$extRef;$invoiceID;$registerId;$accountID;$amount;$currency;$isReceived;$issueDate;$dueDate;$autoCMTPtr;$pctFee;$feeLocal;$ourRate;$spotRate;$customerID;$amountLocal)

// change in version 3.550 -------------------------------------------------------------------

C_TEXT:C284($branchID; $userID; $currencyAlias)
C_REAL:C285($boardBuyRate; $boardSellRate; $tax1; $tax2)
C_DATE:C307($date)
C_BOOLEAN:C305($isTransfer)

$currencyAlias:=$currency  // must change
$boardBuyRate:=0
$boardSellRate:=0
$userID:=getApplicationUser
$branchID:=getBranchID
$date:=$issueDate
$isTransfer:=False:C215
$tax1:=0
$tax2:=0

// there was a bug here instead of [ewires]registerID, it was [AccountInOut]RegisterId. TB - Sep 11, 2011
//issue if this is edited on ewire server or other where the registers are not available - this will create a new register 
//b/c the first call will retunrn a blank register id and the next call will create a new register - IBB
If ($registerId="")  //)ìbb to fix issue described 6/24/21
	[eWires:13]RegisterID:24:=createRegisterFromTable($branchID; $tablePtr; $extRef; $invoiceID; $registerId; $date; $userID; $accountID; $subAccountID; $referenceNo; $amount; $currency; $isReceived; $autoCMTPtr; $pctFee; $feeLocal; $ourRate; $spotRate; $customerID; $amountLocal; $isTransfer; $tax1; $tax2; $currencyAlias; $boardBuyRate; $boardSellRate)
Else   //do NOT reset the ewire register id
	$registerId:=createRegisterFromTable($branchID; $tablePtr; $extRef; $invoiceID; $registerId; $date; $userID; $accountID; $subAccountID; $referenceNo; $amount; $currency; $isReceived; $autoCMTPtr; $pctFee; $feeLocal; $ourRate; $spotRate; $customerID; $amountLocal; $isTransfer; $tax1; $tax2; $currencyAlias; $boardBuyRate; $boardSellRate)
End if 