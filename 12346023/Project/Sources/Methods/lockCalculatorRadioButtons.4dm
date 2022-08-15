//%attributes = {}
// lockCalculatorRadioButtons (radioButtonNumber)

C_LONGINT:C283($1)

OBJECT SET ENTERABLE:C238(*; "calcField1"; True:C214)
OBJECT SET ENTERABLE:C238(*; "calcField2"; True:C214)
OBJECT SET ENTERABLE:C238(*; "calcField3"; True:C214)
OBJECT SET ENTERABLE:C238(*; "calcField4"; True:C214)
OBJECT SET ENTERABLE:C238(*; "calcField"+String:C10($1); False:C215)

rbFromAmount:=0
rbExchangeRate:=0
rbServiceFee:=0
rbToAmount:=0
Case of 
	: ($1=1)
		rbFromAmount:=1
		
	: ($1=2)
		rbExchangeRate:=1
		
	: ($1=3)
		rbServiceFee:=1
		
	: ($1=4)
		rbToAmount:=1
		
End case 