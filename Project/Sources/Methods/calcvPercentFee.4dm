//%attributes = {}
C_LONGINT:C283($sign)
C_REAL:C285($percentFee)

$sign:=Num:C11(vReceivedOrPaid=c_Paid)-Num:C11(vReceivedOrPaid=c_Received)
$percentFee:=calcSafeDivide(100; $sign)*(calcSafeDivide(vAmountLocal-($sign*vFeeLocal); vAmount*vRate)-1)
vPercentFee:=$percentFee