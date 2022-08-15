//%attributes = {}
// setItemInOutFieldsToInvoiceVars (isPaid:bool; ItemInOutID)

C_POINTER:C301($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyptr; $isPaidPtr)
C_POINTER:C301($ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr)
C_BOOLEAN:C305($isPaid; $1)
C_TEXT:C284($primaryKeyValue; $2)

$tablePtr:=->[ItemInOuts:40]
$fieldPtr:=->[ItemInOuts:40]ItemInOutID:1
$invoicePtr:=->[ItemInOuts:40]InvoiceID:4
$datePtr:=->[ItemInOuts:40]Date:3
$dueDatePtr:=->[ItemInOuts:40]Date:3
$customerPtr:=->[ItemInOuts:40]customerID:6
$amountPtr:=->[ItemInOuts:40]Amount:22
$currencyPtr:=->[ItemInOuts:40]Currency:11
$isPaidPtr:=->[ItemInOuts:40]isSold:7
$ourRatePtr:=->[ItemInOuts:40]OurRate:16
$spotRatePtr:=->[ItemInOuts:40]SpotRate:17
$percentFeePtr:=->[ItemInOuts:40]PercentFee:18
$feeLocalPtr:=->[ItemInOuts:40]FeeLocal:19
$amountLocalPtr:=->[ItemInOuts:40]amountLocal:25

$isPaid:=$1
$primaryKeyValue:=$2

setTableFieldsToInvoiceVars($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyPtr; $isPaidPtr; $ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr; $isPaid; $primaryKeyValue)
