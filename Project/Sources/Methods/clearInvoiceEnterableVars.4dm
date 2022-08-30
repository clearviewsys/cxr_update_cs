//%attributes = {}

If (isDuringInvoice)
	setReceivedOrPaid(0)
	//vecCurrency{0}:=""
	setVecCurrency(<>baseCurrency)
	vAmount:=0
	vRate:=0
	vInverseRate:=0
	vAmountLocal_BF:=0
	cbFeeStructure{0}:=""
	
	vPercentFee:=0
	vPercentFeeLocal:=0
	vFeeLocal:=0
	
	vAmountLocal:=0
	vDueDate:=nullDate
	setRadioButtonStatesInInvoice(5)
	C_REAL:C285(vReflection)
	vReflection:=0
End if 