//%attributes = {}
// setAccountInOutFieldsToInvoiceVars (isPaid:bool; AccountInOutID)

C_POINTER:C301($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyptr; $isPaidPtr; $amountLocalPtr)
C_POINTER:C301($ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr)
C_BOOLEAN:C305($isPaid; $1)
C_TEXT:C284($primaryKeyValue; $2)

$tablePtr:=->[AccountInOuts:37]
$fieldPtr:=->[AccountInOuts:37]AccountInOutID:1
$invoicePtr:=->[AccountInOuts:37]InvoiceID:4
$datePtr:=->[AccountInOuts:37]Date:3
$dueDatePtr:=->[AccountInOuts:37]Date:3
$customerPtr:=->[AccountInOuts:37]CustomerID:2
$amountPtr:=->[AccountInOuts:37]Amount:7
$currencyPtr:=->[AccountInOuts:37]Currency:8
$isPaidPtr:=->[AccountInOuts:37]isPaid:9
$ourRatePtr:=->[AccountInOuts:37]ourRate:13
$spotRatePtr:=->[AccountInOuts:37]spotRate:14
$percentFeePtr:=->[AccountInOuts:37]percentFee:15
$feeLocalPtr:=->[AccountInOuts:37]feeLocal:16
$amountLocalPtr:=->[AccountInOuts:37]amountLocal:17

$isPaid:=$1
$primaryKeyValue:=$2

setTableFieldsToInvoiceVars($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyPtr; $isPaidPtr; $ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr; $isPaid; $primaryKeyValue)
