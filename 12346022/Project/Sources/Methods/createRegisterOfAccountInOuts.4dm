//%attributes = {}
// createRegisterOfAccountInOuts


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

$tablePtr:=->[AccountInOuts:37]
$extRef:=[AccountInOuts:37]AccountInOutID:1
$invoiceID:=[AccountInOuts:37]InvoiceID:4
$registerId:=[AccountInOuts:37]RegisterID:5
$accountID:=[AccountInOuts:37]AccountID:6
$subAccountID:=[AccountInOuts:37]SubAccountID:23
$referenceNo:=[AccountInOuts:37]ReferenceNo:22


$amount:=[AccountInOuts:37]Amount:7
$currency:=[AccountInOuts:37]Currency:8
$isReceived:=Not:C34([AccountInOuts:37]isPaid:9)
$issueDate:=[AccountInOuts:37]Date:3
$dueDate:=[AccountInOuts:37]Date:3
$autoCMTPtr:=->[AccountInOuts:37]autoComment:12
$pctFee:=[AccountInOuts:37]percentFee:15
$feeLocal:=[AccountInOuts:37]feeLocal:16
$ourRate:=[AccountInOuts:37]ourRate:13
$spotRate:=[AccountInOuts:37]spotRate:14
$customerID:=[AccountInOuts:37]CustomerID:2
$amountLocal:=[AccountInOuts:37]amountLocal:17

[AccountInOuts:37]autoComment:12:=makeCommentsAccountInOuts
//[AccountInOuts]RegisterID:=createRegisterFromTable ($tablePtr;$extRef;$invoiceID;$registerId;$accountID;$amount;$currency;$isReceived;$issueDate;$dueDate;$autoCMTPtr;$pctFee;$feeLocal;$ourRate;$spotRate;$customerID;$amountLocal)

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

[AccountInOuts:37]RegisterID:5:=createRegisterFromTable($branchID; $tablePtr; $extRef; $invoiceID; $registerId; $date; $userID; $accountID; $subAccountID; $referenceNo; $amount; $currency; $isReceived; $autoCMTPtr; $pctFee; $feeLocal; $ourRate; $spotRate; $customerID; $amountLocal; $isTransfer; $tax1; $tax2; $currencyAlias; $boardBuyRate; $boardSellRate)
