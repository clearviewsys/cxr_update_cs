//%attributes = {}
// setReceivedOrPay ( {1: received;2:paid})
C_LONGINT:C283($1)

vReceivedOrPaid:=getReceivedOrPayString($1)
Case of 
	: ($1=0)  // null
		// @Zoya - 30 July 2021
		OBJECT SET FONT STYLE:C166(*; "b_Buy"; 0)
		OBJECT SET FONT STYLE:C166(*; "b_Sell"; 0)
		setRGBColourBG("vAmount"; 255; 255; 255)
		setRGBColourBG("vReceivedPaid"; 235; 235; 235)
		setRGBColourBG("vAmountLocal_BF"; 255; 255; 255)
		setRGBColourBG("vAmountLocal"; 255; 255; 255)
		setRGBColourBG("backDropRect"; 100; 100; 100)
		
		//GOTO AREA(*;"vReceivedPaid")
		
	: ($1=1)  // received
		
		// @Zoya - 30 July 2021
		OBJECT SET FONT STYLE:C166(*; "b_Buy"; 1)
		OBJECT SET FONT STYLE:C166(*; "b_Sell"; 0)
		
		setFieldColourToLightBlue("vAmount")
		setFieldColourToLightBlue("vReceivedPaid")
		setFieldColourToLightYellow("vAmountLocal_BF")
		setFieldColourToLightYellow("vAmountLocal")
		//setRGBColourBG ("1";130;180;190)
		setRGBColourBG("backDropRect"; 140; 180; 255)
		
	: ($1=2)  // paid
		
		// @Zoya - 30 July 2021
		OBJECT SET FONT STYLE:C166(*; "b_Sell"; 1)
		OBJECT SET FONT STYLE:C166(*; "b_Buy"; 0)
		
		setFieldColourToLightYellow("vAmount")
		setFieldColourToLightYellow("vReceivedPaid")
		setFieldColourToLightBlue("vAmountLocal_BF")
		setFieldColourToLightBlue("vAmountLocal")
		setRGBColourBG("backDropRect"; 230; 120; 120)
		
		
End case 

setVisibleIff(($1=1); "labelWeBuy")
setVisibleIff(($1=2); "labelWeSell")

