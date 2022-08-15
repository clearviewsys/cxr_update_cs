//%attributes = {}
// createRegisterOfCheques


C_POINTER:C301($tablePtr)
C_TEXT:C284($extRef; $invoiceID; $registerId; $accountID; $subAccountID; $referenceNo)
C_REAL:C285($amount)
C_TEXT:C284($currency)
C_BOOLEAN:C305($isReceived)
C_DATE:C307($issueDate; $dueDate; $registerDate)
C_POINTER:C301($autoCMTPtr)
C_REAL:C285($pctFee; $feeLocal; $ourRate; $spotRate)
C_TEXT:C284($customerID)
C_REAL:C285($amountLocal)
C_TEXT:C284($branchID; $userID)

C_BOOLEAN:C305($isTransfer)
C_TEXT:C284($currencyAlias)
C_REAL:C285($boardBuyRate; $boardSellRate)

$branchID:=getBranchID
$userID:=getApplicationUser

$tablePtr:=->[CashTransactions:36]
$extRef:=[CashTransactions:36]CashTransactionID:1
$invoiceID:=[CashTransactions:36]InvoiceID:7
$registerId:=[CashTransactions:36]registerID:8

$accountID:=[CashTransactions:36]CashAccountID:9
$subAccountID:=[CashTransactions:36]SubAccountID:23
$referenceNo:=[CashTransactions:36]ReferenceNo:24

$amount:=[CashTransactions:36]Amount:3
$currency:=[CashTransactions:36]Currency:4
$isReceived:=Not:C34([CashTransactions:36]isPaid:2)
$registerDate:=[CashTransactions:36]Date:5
$dueDate:=[CashTransactions:36]Date:5
$autoCMTPtr:=->[CashTransactions:36]autoComment:14
$pctFee:=[CashTransactions:36]percentFee:17
$feeLocal:=[CashTransactions:36]feeLocal:18
$ourRate:=[CashTransactions:36]ourRate:15
$spotRate:=[CashTransactions:36]spotRate:16
$customerID:=[CashTransactions:36]CustomerID:10
$amountLocal:=[CashTransactions:36]amountLocal:19

$currencyAlias:=[CashTransactions:36]Currency:4  // THIS MUST CHANGE!!!!!!  IT SHOULD RECORD the currency alias instead of the currency itself
$boardBuyRate:=0  // THESE SHOULD RECORD THE BOARD BUY AND SELL RATE NOT 
$boardSellRate:=0

$isTransfer:=False:C215

[CashTransactions:36]autoComment:14:=makeCommentsCashTransactions
//[CashTransactions]registerID:=createRegisterFromTable ($tablePtr;$extRef;$invoiceID;$registerId;$accountID;$amount;$currency;$isReceived;$issueDate;$dueDate;$autoCMTPtr;$pctFee;$feeLocal;$ourRate;$spotRate;$customerID;$amountLocal)

// change since version 3.550
[CashTransactions:36]registerID:8:=createRegisterFromTable($branchID; $tablePtr; $extRef; $invoiceID; $registerId; $registerDate; $userID; $accountID; $subAccountID; $referenceNo; $amount; $currency; $isReceived; $autoCMTPtr; $pctFee; $feeLocal; $ourRate; $spotRate; $customerID; $amountLocal; $isTransfer; 0; 0; $currencyAlias; $boardBuyRate; $boardSellRate)
