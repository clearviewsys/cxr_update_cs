//%attributes = {}
// method (
//$1: switch:boolean
//$2: isReceived
//$3:  currency
//$4: ->amount
//$5: ->rate
//$6: ->commission
//$7: ->feeLocal
//$8: ->amountLocal;
//$9: ->amountLocalBeforeFees
//$10: ->percentFeeLocal
//$11: ->totalFees
//$12: ->inverseRate



C_LONGINT:C283($switch; $1)
C_BOOLEAN:C305($isPaid; $isReceived; $2)
C_TEXT:C284($currency; $3)
C_POINTER:C301($4; $5; $6; $7; $8; $9; $10; $11; $12)
C_POINTER:C301($amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
C_LONGINT:C283($currencyRounding)

$switch:=$1
$isReceived:=$2
$isPaid:=Not:C34($2)

$currency:=$3

$amountPtr:=$4
$ratePtr:=$5
$percentPtr:=$6
$feeLocalPtr:=$7
$amountLocalPtr:=$8
$amountLocalBFPtr:=$9
$percentFeeLocalPtr:=$10
$totalFeesPtr:=$11
$inverseRatePtr:=$12

C_REAL:C285($amount; $rate; $percent; $feeLocal; $amountLocal; $amountLocalBF; $percentFeeLocal; $totalFees; $inverseRate; $sign; $amount; $rate; $percent; $feeLocal; $amountLocal)
$amount:=Abs:C99($amountPtr->)
$rate:=$ratePtr->
$percent:=$percentPtr->
$feeLocal:=$feeLocalPtr->
$amountLocal:=$amountLocalPtr->
$amountLocalBF:=$amountLocalBFPtr->
$percentFeeLocal:=$percentFeeLocalPtr->
$totalFees:=$totalFeesPtr->
$inverseRate:=$inverseRatePtr->

$sign:=Num:C11($isPaid)-Num:C11($isReceived)
selectCurrencyByAlias($currency)
$currencyRounding:=[Currencies:6]RoundLowestDenom:13
Case of 
	: ($switch=1)  //vAmount
		$amount:=Round:C94(calcSafeDivide($amountLocal-($FeeLocal*$sign); $Rate*(1+($sign*$Percent/100))); $currencyRounding)
		$amountPtr->:=$amount
	: ($switch=2)  // vRate
		$rate:=Round:C94(calcSafeDivide($amountLocal-($sign*$FeeLocal); $Amount*(1+($sign*$Percent/100))); 10)
		$ratePtr->:=$rate
		//setvRate 
	: ($switch=3)  //vPercentFee
		$percent:=Round:C94(calcSafeDivide(100; $sign)*(calcSafeDivide($amountLocal-($sign*$FeeLocal); $Amount*$Rate)-1); 4)
		$PercentPtr->:=$percent
	: ($switch=4)  // vFeeLocal
		$feeLocal:=roundToBase(calcSafeDivide($AmountLocal-($Amount*$Rate*(1+($sign*$Percent/100))); $sign))
		$FeeLocalPtr->:=$feeLocal
	: ($switch=5)  // vAmountLocal
		//calcvamountLocal
		$amountLocal:=roundToBase(($Amount*$Rate*(1+($sign*$Percent/100)))+($sign*$FeeLocal))
		$AmountLocalPtr->:=$amountLocal
End case 

$inverseRate:=Round:C94(calcSafeDivide(1; $rate); [Currencies:6]RoundDigitInverse:28)

$inverseRatePtr->:=$inverseRate

$AmountLocalBF:=roundToBase($Amount*$Rate)
$amountLocalBFPtr->:=$amountLocalBF

$PercentFeeLocal:=roundToBase($AmountLocalBF*($Percent/100))
$TotalFees:=roundToBase($PercentFeeLocal+$FeeLocal)
$percentFeeLocalPtr->:=$percentFeeLocal
$totalFeesPtr->:=$totalFees

//  calcFeesInInvoice ($amountLocalBF;$percent;$feeLocal;$percentPtr;$fee
//normalizeVarsInInvoice
