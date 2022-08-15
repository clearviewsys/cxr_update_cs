//%attributes = {}
// calcvAmount 
// used in invoice
//Unit Test not completed @Zoya

C_REAL:C285($Amount; $vDelta; $amountRounded)
C_LONGINT:C283($sign)
C_REAL:C285($amount)

$sign:=Num:C11(vReceivedOrPaid=c_Paid)-Num:C11(vReceivedOrPaid=c_Received)


$amount:=calcSafeDivide(vAmountLocal-(vFeeLocal*$sign); vRate*(1+($sign*vPercentFee/100)))
vAmount:=$amount