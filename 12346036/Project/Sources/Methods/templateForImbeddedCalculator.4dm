//%attributes = {}
// THIS CODE CAN BE INCLUDED IN FORM METHODS FOR (PAY/RECEIVE) IN PAYMENT METHOD FORMS (EX: CHEQUES)
// REMEMBER TO FIND AND REPLACE THE [CASHTRANSACTIONS] with the [TABLE] you are imbedding this to

//_______________________________HANDLING THE LITTLE IMBEDDED CALCULATOR_________________________
C_LONGINT:C283($switch)
C_BOOLEAN:C305($isPaid; $isReceived; $isCashIn)
C_POINTER:C301($amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
C_REAL:C285(vAmountLocal_BF; vPercentFeeLocal; vTotalFees; vInverseRate)
C_TEXT:C284($currency; vCurrency)

$switch:=5
$isReceived:=$isCashIn
$isPaid:=Not:C34($isReceived)
$currency:=[CashTransactions:36]Currency:4

$amountPtr:=->[CashTransactions:36]Amount:3
$ratePtr:=->[CashTransactions:36]ourRate:15
$percentPtr:=->[CashTransactions:36]percentFee:17
$feeLocalPtr:=->[CashTransactions:36]feeLocal:18
$amountLocalPtr:=->[CashTransactions:36]amountLocal:19
$amountLocalBFPtr:=->vAmountLocal_BF
$percentFeeLocalPtr:=->vPercentFeeLocal
$totalFeesPtr:=->vTotalFees
$inverseRatePtr:=->vInverseRate
calculateFieldsInInvoiceRows($switch; $isReceived; $currency; $amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
//_________________________________________________________________________________________
