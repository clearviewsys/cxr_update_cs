//%attributes = {}
// setTableFieldsToInvoiceVars (
// 1: ->table;
// 2: ->primaryKey;
// 3: ->invoiceID;
// 4: ->issueDate;
// 5: ->dueDate;
// 6: ->customerID;
// 7: ->amount
// 8: ->currency
// 9: ->isPaid
//10:->ourRate 
//11:->spotRate
//12:->percentFee
//13:->feeLocal

C_POINTER:C301($tablePtr; $fieldPtr; $invoicePtr; $datePtr; $dueDatePtr; $customerPtr; $amountPtr; $currencyptr; $isPaidPtr)
C_POINTER:C301($ourRatePtr; $spotRatePtr; $percentFeePtr; $feeLocalPtr; $amountLocalPtr)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14)
C_BOOLEAN:C305($isPaid; $15)
C_TEXT:C284($primaryKeyValue; $16)

$tablePtr:=$1
$fieldPtr:=$2
$invoicePtr:=$3
$datePtr:=$4
$dueDatePtr:=$5
$customerPtr:=$6
$amountPtr:=$7
$currencyPtr:=$8
$isPaidPtr:=$9
$ourRatePtr:=$10
$spotRatePtr:=$11
$percentFeePtr:=$12
$feeLocalPtr:=$13
$amountLocalPtr:=$14

$isPaid:=$15
$primaryKeyValue:=$16

$fieldPtr->:=$primaryKeyValue
$invoicePtr->:=vInvoiceNumber
$datePtr->:=vInvoiceDate
$dueDatePtr->:=vInvoiceDate
$customerPtr->:=vCustomerID
$amountPtr->:=vAmount
$currencyPtr->:=vCurrency
$isPaidPtr->:=$isPaid
$ourRatePtr->:=vRate
$spotRatePtr->:=vSpotRate
$percentFeePtr->:=vPercentFee
$feeLocalPtr->:=vFeeLocal
$amountLocalPtr->:=vAmountLocal


















