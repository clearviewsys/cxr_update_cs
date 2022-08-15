//%attributes = {}
// handleCalculationFields (radioButton{1-5};isPaid; curr;->amount;->rate;->percentFee;->feeLocal;->amountLocal)
//Unit Test to be completed by @Zoya

C_LONGINT:C283($switch; $1)
C_BOOLEAN:C305($isPaid; $2)
C_TEXT:C284($currency; $3)
C_POINTER:C301($amountPtr; $ouRatePtr; $pctFeePtr; $feeLocalPtr; $amountLocalPtr; $ourRatePtr; $4; $5; $6; $7; $8)
$switch:=$1
$isPaid:=$2
$currency:=$3
$amountPtr:=$4
$ourRatePtr:=$5
$pctFeePtr:=$6
$feeLocalPtr:=$7
$amountLocalPtr:=$8

Case of 
	: ($switch=1)  //vAmount
		$amountPtr->:=calc_Amount($isPaid; $amountPtr->; $currency; $ourRatePtr->; $pctFeePtr->; $feeLocalPtr->; $amountLocalPtr->)
	: ($switch=2)  // vRate
		$ourratePtr->:=calc_Rate($isPaid; $amountPtr->; $currency; $ourRatePtr->; $pctFeePtr->; $feeLocalPtr->; $amountLocalPtr->)
	: ($switch=3)  //vPercentFee
		$pctFeePtr->:=calc_PercentFee($isPaid; $amountPtr->; $currency; $ourRatePtr->; $pctFeePtr->; $feeLocalPtr->; $amountLocalPtr->)
	: ($switch=4)  // vFeeLocal
		$feeLocalPtr->:=calc_FeeLocal($isPaid; $amountPtr->; $currency; $ourRatePtr->; $pctFeePtr->; $feeLocalPtr->; $amountLocalPtr->)
	: ($switch=5)  // vAmountLocal
		$amountLocalPtr->:=calc_AmountLocal($isPaid; $amountPtr->; $currency; $ourRatePtr->; $pctFeePtr->; $feeLocalPtr->; $amountLocalPtr->)
End case 
