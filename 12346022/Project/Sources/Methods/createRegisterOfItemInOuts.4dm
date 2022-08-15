//%attributes = {}
C_POINTER:C301($tablePtr)
C_TEXT:C284($extRef; $invoiceID; $registerId; $accountID; $subAccountID; $referenceNo)
C_REAL:C285($amount; $tax1; $tax2)
C_TEXT:C284($currency)
C_BOOLEAN:C305($isReceived)
C_DATE:C307($issueDate; $dueDate)
C_POINTER:C301($autoCMTPtr)
C_REAL:C285($pctFee; $feeLocal; $ourRate; $spotRate)
C_TEXT:C284($customerID)
C_REAL:C285($amountLocal)

C_TEXT:C284($branchID; $userID; $currencyAlias)
C_REAL:C285($boardBuyRate; $boardSellRate)
C_DATE:C307($date)
C_BOOLEAN:C305($isTransfer)


$tablePtr:=->[ItemInOuts:40]
$extRef:=[ItemInOuts:40]ItemInOutID:1
$invoiceID:=[ItemInOuts:40]InvoiceID:4
$registerId:=[ItemInOuts:40]registerID:5

$accountID:=[ItemInOuts:40]accountID:13

If ([ItemInOuts:40]SubAccountID:27="")
	$subAccountID:=[ItemInOuts:40]ItemID:2
Else 
	$subAccountID:=[ItemInOuts:40]SubAccountID:27
End if 

$referenceNo:=[ItemInOuts:40]ReferenceNo:28

$amount:=[ItemInOuts:40]Amount:22
$currency:=<>baseCurrency
$isReceived:=Not:C34([ItemInOuts:40]isSold:7)
$issueDate:=[ItemInOuts:40]Date:3
$dueDate:=[ItemInOuts:40]Date:3
$autoCMTPtr:=->[ItemInOuts:40]autoComment:14
$pctFee:=0
$feeLocal:=0
$ourRate:=1
$spotRate:=1
$customerID:=[ItemInOuts:40]customerID:6
$amountLocal:=[ItemInOuts:40]Amount:22  // this was changed from amountlocal to amount in version 3.561 by TB

$tax1:=[ItemInOuts:40]tax1:20
$tax2:=[ItemInOuts:40]tax2:21

[ItemInOuts:40]autoComment:14:=makeCommentsItemInOuts
//[ItemInOuts]registerID:=createRegisterFromTable ($tablePtr;$extRef;$invoiceID;$registerId;$accountID;$amount;$currency;$isReceived;$issueDate;$dueDate;$autoCMTPtr;$pctFee;$feeLocal;$ourRate;$spotRate;$customerID;$amount;$tax1;$tax2)
// change in version 3.550 -------------------------------------------------------------------



$currencyAlias:=$currency  // must change
$boardBuyRate:=0
$boardSellRate:=0
$userID:=getApplicationUser
$branchID:=getBranchID
$date:=$issueDate
$isTransfer:=False:C215

[ItemInOuts:40]registerID:5:=createRegisterFromTable($branchID; $tablePtr; $extRef; $invoiceID; $registerId; $date; $userID; $accountID; $subAccountID; $referenceNo; $amount; $currency; $isReceived; $autoCMTPtr; $pctFee; $feeLocal; $ourRate; $spotRate; $customerID; $amountLocal; $isTransfer; $tax1; $tax2; $currencyAlias; $boardBuyRate; $boardSellRate)
