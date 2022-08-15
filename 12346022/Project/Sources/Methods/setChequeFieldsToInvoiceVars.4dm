//%attributes = {}
// setChequeFieldsToInvoiceVars (isPaid:bool; chequeID)

C_POINTER:C301($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyptr; $isPaidPtr)
C_POINTER:C301($ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr)
C_BOOLEAN:C305($isPaid; $1)
C_TEXT:C284($primaryKeyValue; $2)

$tablePtr:=->[Cheques:1]
$fieldPtr:=->[Cheques:1]ChequeID:1
$invoicePtr:=->[Cheques:1]InvoiceID:5
$datePtr:=->[Cheques:1]IssueDate:16
$dueDatePtr:=->[Cheques:1]DueDate:3
$customerPtr:=->[Cheques:1]CustomerID:2
$amountPtr:=->[Cheques:1]Amount:8
$currencyPtr:=->[Cheques:1]Currency:9
$isPaidPtr:=->[Cheques:1]isPaid:11
$ourRatePtr:=->[Cheques:1]ourRate:19
$spotRatePtr:=->[Cheques:1]spotRate:22
$percentFeePtr:=->[Cheques:1]PercentFee:20
$feeLocalPtr:=->[Cheques:1]feeLocal:21
$amountLocalPtr:=->[Cheques:1]amountLocal:23

$isPaid:=$1
$primaryKeyValue:=$2

setTableFieldsToInvoiceVars($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyPtr; $isPaidPtr; $ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr; $isPaid; $primaryKeyValue)
