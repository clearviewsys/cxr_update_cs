//%attributes = {}
// seteWireFieldsToInvoiceVars (isPaid:bool; eWireID)

C_POINTER:C301($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyptr; $isPaidPtr; $amountLocalPtr)
C_POINTER:C301($ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr)
C_BOOLEAN:C305($isPaid; $1)
C_TEXT:C284($primaryKeyValue; $2)

$tablePtr:=->[eWires:13]
$fieldPtr:=->[eWires:13]eWireID:1
$invoicePtr:=->[eWires:13]InvoiceNumber:29
$datePtr:=->[eWires:13]SendDate:2
$dueDatePtr:=->[eWires:13]SendDate:2
$customerPtr:=->[eWires:13]CustomerID:15
If ([eWires:13]isPaymentSent:20)
	$amountPtr:=->[eWires:13]FromAmount:13
	$currencyPtr:=->[eWires:13]FromCurrency:11
Else 
	$amountPtr:=->[eWires:13]ToAmount:14
	$currencyPtr:=->[eWires:13]Currency:12
End if 

$isPaidPtr:=->[eWires:13]isPaymentSent:20
$ourRatePtr:=->[eWires:13]sourceRate:41
$spotRatePtr:=->[eWires:13]sourceSpotRate:42
$percentFeePtr:=->[eWires:13]sourcePCTFee:43
$feeLocalPtr:=->[eWires:13]sourceServicefeeLocal:44
$amountLocalPtr:=->[eWires:13]amountLocal:45

$isPaid:=$1
$primaryKeyValue:=$2

setTableFieldsToInvoiceVars($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyPtr; $isPaidPtr; $ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr; $isPaid; $primaryKeyValue)
