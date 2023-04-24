//%attributes = {}
// setCashTransactionFieldsToInvoiceVars (isPaid:bool; CashTransactionID)

C_POINTER:C301($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyptr; $isPaidPtr)
C_POINTER:C301($ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr)
C_BOOLEAN:C305($isPaid; $1)
C_TEXT:C284($primaryKeyValue; $2)

$tablePtr:=->[CashTransactions:36]
$fieldPtr:=->[CashTransactions:36]CashTransactionID:1
$invoicePtr:=->[CashTransactions:36]InvoiceID:7
$datePtr:=->[CashTransactions:36]Date:5
$dueDatePtr:=->[CashTransactions:36]Date:5
$customerPtr:=->[CashTransactions:36]CustomerID:10
$amountPtr:=->[CashTransactions:36]Amount:3
$currencyPtr:=->[CashTransactions:36]Currency:4
$isPaidPtr:=->[CashTransactions:36]isPaid:2
$ourRatePtr:=->[CashTransactions:36]ourRate:15
$spotRatePtr:=->[CashTransactions:36]spotRate:16
$percentFeePtr:=->[CashTransactions:36]percentFee:17
$feeLocalPtr:=->[CashTransactions:36]feeLocal:18
$amountLocalPtr:=->[CashTransactions:36]amountLocal:19  // new addition

$isPaid:=$1
$primaryKeyValue:=$2

setTableFieldsToInvoiceVars($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyPtr; $isPaidPtr; $ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr; $isPaid; $primaryKeyValue)
