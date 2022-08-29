//%attributes = {}
// calcvRate
//calculated the vRate based on other vars

C_LONGINT:C283($sign)
C_REAL:C285($rate)

$sign:=Num:C11(vReceivedOrPaid=c_Paid)-Num:C11(vReceivedOrPaid=c_Received)
$rate:=calcSafeDivide(vAmountLocal-($sign*vFeeLocal); vAmount*(1+($sign*vPercentFee/100)))
vRate:=$rate
setvRate