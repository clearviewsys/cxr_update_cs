//%attributes = {}
// setWireFieldsToInvoiceVars (isPaid:bool; WireID)

C_POINTER:C301($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyptr; $isPaidPtr)
C_POINTER:C301($ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr)
C_BOOLEAN:C305($isPaid; $1)
C_TEXT:C284($primaryKeyValue; $2)

$tablePtr:=->[Wires:8]
$fieldPtr:=->[Wires:8]CXR_WireID:1
$invoicePtr:=->[Wires:8]CXR_InvoiceID:12
$datePtr:=->[Wires:8]WireTransferDate:17
$dueDatePtr:=->[Wires:8]EstimatedValueDate:18
$customerPtr:=->[Wires:8]CustomerID:2
$amountPtr:=->[Wires:8]Amount:14
$currencyPtr:=->[Wires:8]Currency:15
$isPaidPtr:=->[Wires:8]isOutgoingWire:16
$ourRatePtr:=->[Wires:8]OurRate:21
$spotRatePtr:=->[Wires:8]SpotRate:22
$percentFeePtr:=->[Wires:8]PercentageFee:23
$feeLocalPtr:=->[Wires:8]FlatFeeLocal:24
$amountLocalPtr:=->[Wires:8]AmountLocal:25

$isPaid:=$1
$primaryKeyValue:=$2

setTableFieldsToInvoiceVars($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyPtr; $isPaidPtr; $ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr; $isPaid; $primaryKeyValue)
