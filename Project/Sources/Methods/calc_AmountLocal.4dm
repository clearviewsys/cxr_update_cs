//%attributes = {}
// calcAmountLocal (isPaid; amount;currency; rate; percentFee; feelocal; amountLocal)
// Unit Test done @Zoya 

C_BOOLEAN:C305($isPaid; $1)
C_TEXT:C284($currency; $3)
C_REAL:C285($rate; $feeLocal; $percentFee; $amountLocal; $amount; $2; $4; $5; $6; $7; $0)
C_LONGINT:C283($sign)

$isPaid:=$1
$amount:=$2
$currency:=$3
$rate:=$4
$percentFee:=$5
$feeLocal:=$6
$amountLocal:=$7

$sign:=Num:C11($isPaid)-Num:C11(Not:C34($isPaid))

$amountLocal:=($Amount*$Rate*(1+($sign*$PercentFee/100)))+($sign*$FeeLocal)
$0:=roundToBase($amountLocal)