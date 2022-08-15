//%attributes = {}
// setRadioButtonStatesInInvoice (number 1-5)
// it will set the radion button rb1 to rb5 to 1

C_LONGINT:C283(rb1; rb2; rb3; rb4; rb5)
C_LONGINT:C283($1)

rb1:=0
rb2:=0
rb3:=0
rb4:=0
rb5:=0
//SET ENTERABLE(*;"vAmount";True)
OBJECT SET ENTERABLE:C238(*; "vRate"; True:C214)
OBJECT SET ENTERABLE:C238(*; "vInverseRate"; True:C214)

OBJECT SET ENTERABLE:C238(*; "vPercentFee"; True:C214)
OBJECT SET ENTERABLE:C238(*; "vFeeLocal"; True:C214)
//SET ENTERABLE(*;"vAmountLocal";True)

Case of 
	: ($1=1)
		rb1:=1
		//SET ENTERABLE(*;"vAmount";False)
		
	: ($1=2)
		rb2:=1
		OBJECT SET ENTERABLE:C238(*; "vRate"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "vInverseRate"; False:C215)
		
	: ($1=3)
		rb3:=1
		OBJECT SET ENTERABLE:C238(*; "vPercentFee"; False:C215)
		
	: ($1=4)
		rb4:=1
		OBJECT SET ENTERABLE:C238(*; "vFeeLocal"; False:C215)
		
	: ($1=5)
		rb5:=1
		//SET ENTERABLE(*;"vAmountLocal";False)
		
End case 

setVisibleIff(($1=1); "bgAmount")
setVisibleIff(($1=2); "bgExchangeRate")
setVisibleIff(($1=3) | ($1=4); "bgFees")
setVisibleIff(($1=5); "bgLocalAmount")
