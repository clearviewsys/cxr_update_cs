//%attributes = {}
//calcvAmountLocal_BF(amount;rate)->amount

C_REAL:C285($1; $2; $0)

Case of 
	: (Count parameters:C259=0)
		vAmountLocal_BF:=vAmount*vRate
		
	: (Count parameters:C259=2)
		$0:=roundToBase($1*$2)
End case 