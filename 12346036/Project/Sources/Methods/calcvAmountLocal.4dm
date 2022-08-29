//%attributes = {}
C_LONGINT:C283($sign)
C_REAL:C285($amountLocal)

$sign:=Num:C11(vReceivedOrPaid=c_Paid)-Num:C11(vReceivedOrPaid=c_Received)
$amountLocal:=(vAmount*vRate*(1+($sign*vPercentFee/100)))+($sign*vFeeLocal)
vAmountLocal:=$amountLocal