//%attributes = {}
// createRegisterOfCheques

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


$tablePtr:=->[Cheques:1]
$extRef:=[Cheques:1]ChequeID:1
$invoiceID:=[Cheques:1]InvoiceID:5
$registerId:=[Cheques:1]RegisterID:6
$accountID:=[Cheques:1]AccountID:7

If ([Cheques:1]SubAccountID:29="")
	$subAccountID:=[Cheques:1]chequeType:13
Else 
	$subAccountID:=[Cheques:1]SubAccountID:29
End if 
$referenceNo:=[Cheques:1]ChequeNumber:4

$amount:=[Cheques:1]Amount:8
$currency:=[Cheques:1]Currency:9
$isReceived:=Not:C34([Cheques:1]isPaid:11)
$issueDate:=[Cheques:1]IssueDate:16
$dueDate:=[Cheques:1]DueDate:3
$autoCMTPtr:=->[Cheques:1]autoComment:18
$pctFee:=[Cheques:1]PercentFee:20
$feeLocal:=[Cheques:1]feeLocal:21
$ourRate:=[Cheques:1]ourRate:19
$spotRate:=[Cheques:1]spotRate:22
$customerID:=[Cheques:1]CustomerID:2
$amountLocal:=[Cheques:1]amountLocal:23

[Cheques:1]autoComment:18:=makeCommentsCheques
//[Cheques]RegisterID:=createRegisterFromTable ($tablePtr;$extRef;$invoiceID;$registerId;$accountID;$amount;$currency;$isReceived;$issueDate;$dueDate;$autoCMTPtr;$pctFee;$feeLocal;$ourRate;$spotRate;$customerID;$amountLocal)

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


// Modified by: Tiran Behrouz (12/4/12)
// if the check is in the accounts payable then the date will be the issue date, otherwise, we deposit it in the future in the correct bank
// this method can be improved to consider the 'pending' account instead of just the chequePayable account. 
If ([Cheques:1]AccountID:7=makeChequePayable([Cheques:1]Currency:9))
	$date:=$issueDate
Else 
	$date:=$dueDate
End if 

$isTransfer:=False:C215
$tax1:=0
$tax2:=0

[Cheques:1]RegisterID:6:=createRegisterFromTable($branchID; $tablePtr; $extRef; $invoiceID; $registerId; $date; $userID; $accountID; $subAccountID; $referenceNo; $amount; $currency; $isReceived; $autoCMTPtr; $pctFee; $feeLocal; $ourRate; $spotRate; $customerID; $amountLocal; $isTransfer; $tax1; $tax2; $currencyAlias; $boardBuyRate; $boardSellRate)
