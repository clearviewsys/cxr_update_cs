//%attributes = {}
C_LONGINT:C283($sign)
C_REAL:C285($fee)

$sign:=Num:C11(vReceivedOrPaid=c_Paid)-Num:C11(vReceivedOrPaid=c_Received)
$fee:=calcSafeDivide(vAmountLocal-(vAmount*vRate*(1+($sign*vPercentFee/100))); $sign)
vFeeLocal:=$fee
