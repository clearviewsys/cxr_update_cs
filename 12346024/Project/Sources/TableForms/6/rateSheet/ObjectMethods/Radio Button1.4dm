C_LONGINT:C283(cbUseInverseRates)

If (cbUseInverseRates=1)
	OBJECT SET ENTERABLE:C238(*; "ourBuyRate"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "spotRate"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "ourSellRate"; False:C215)
	
	OBJECT SET ENTERABLE:C238(*; "invBuyRate"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "invSpotRate"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "invSellRate"; True:C214)
	
Else 
	OBJECT SET ENTERABLE:C238(*; "ourBuyRate"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "spotRate"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "ourSellRate"; True:C214)
	
	OBJECT SET ENTERABLE:C238(*; "invBuyRate"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "invSpotRate"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "invSellRate"; False:C215)
	
End if 
