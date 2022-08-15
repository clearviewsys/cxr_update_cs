//%attributes = {}
// calcFeesInInvoice() or
// calcFeesInInvoice (amountLocalBeforeFees;percentFee;feeLocal;->percentFeeLocal;->totalFeesLocal)


C_REAL:C285(vPercentFeeLocal; vAmountLocal_BF; vPercentFee; vTotalFeesLocal; vFeeLocal)
C_REAL:C285($1; $2; $3)
C_POINTER:C301($4; $5)

Case of 
	: (Count parameters:C259=0)
		vPercentFeeLocal:=vAmountLocal_BF*(vPercentFee/100)
		vTotalFeesLocal:=vPercentFeeLocal+vFeeLocal
	: (Count parameters:C259=5)
		$4->:=roundToBase($1*($2/100))
		$5->:=($4->)+($3)
		
End case 