//%attributes = {}
// createRegisterOfMGWebeWire ($isInInvoice)

C_POINTER:C301($tablePtr; $autoCMTPtr)
C_TEXT:C284($extRef; $registerId; $subAccountID; $referenceNo; $currency; $customerID; $currencyAlias; $branchID; $userID)
C_REAL:C285($amount; $boardBuyRate; $boardSellRate; $amountLocal; $pctFee; $feeLocal; $ourRate; $spotRate)
C_BOOLEAN:C305($isReceived; $isTransfer; $isOfflineMethod; $1)
C_DATE:C307($issueDate; $dueDate)
C_OBJECT:C1216($paymentInfo)

If (Count parameters:C259=1)
	$isOfflineMethod:=$1
Else 
	$isOfflineMethod:=False:C215
End if 

C_TEXT:C284($2; $invoiceID; $createdRegisterID)
$invoiceID:=$2

C_TEXT:C284($3; $accountID)
$accountID:=$3

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

$paymentInfo:=[WebEWires:149]paymentInfo:35

$referenceNo:=$paymentInfo.result.referenceNumber
$tablePtr:=->[WebEWires:149]
$extRef:=[WebEWires:149]WebEwireID:1
$isReceived:=Not:C34([WebEWires:149]isSent:22)
$customerID:=[WebEWires:149]CustomerID:21
$autoCMTPtr:=->[WebEWires:149]Notes:17
$dueDate:=mgGetDateFromProfixDateTime($paymentInfo.result.transactionDateTime)
$issueDate:=$dueDate
$date:=$issueDate
$subAccountID:=""

$ourRate:=[WebEWires:149]directRate:13

// different parameters for two registers

// $feeLocal:=$paymentInfo.localFee 

If ($paymentInfo.result.transactionType="Send")
	
	// $amountLocal:=[WebEWires]fromAmount+$paymentInfo.localFee
	$feeLocal:=Num:C11($paymentInfo.result.sendFee)
	$amountLocal:=[WebEWires:149]fromAmount:3+$feeLocal
	$amount:=[WebEWires:149]fromAmount:3
	$currency:=[WebEWires:149]fromCCY:5
	$isReceived:=False:C215
	
Else 
	
	$amount:=[WebEWires:149]toAmount:10
	// $amountLocal:=[WebEWires]toAmount+$paymentInfo.localFee
	$amountLocal:=[WebEWires:149]toAmount:10
	$currency:=[WebEWires:149]toCCY:11
	$isReceived:=True:C214
	
End if 

$registerId:=""

If ($paymentInfo.registerID#Null:C1517)
	$registerId:=$paymentInfo.registerID
End if 

$createdRegisterID:=createRegisterFromTable($branchID; $tablePtr; $extRef; $invoiceID; $registerId; $date; $userID; $accountID; $subAccountID; $referenceNo; $amount; $currency; $isReceived; $autoCMTPtr; $pctFee; $feeLocal; $ourRate; $spotRate; $customerID; $amountLocal; $isTransfer; $tax1; $tax2; $currencyAlias; $boardBuyRate; $boardSellRate)
$paymentInfo.registerID:=$createdRegisterID

$paymentInfo.invoiceID:=$invoiceID

If (Not:C34(Locked:C147([WebEWires:149])))
	SAVE RECORD:C53([WebEWires:149])
Else 
	// TRACE
End if 
