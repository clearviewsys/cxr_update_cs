OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
C_LONGINT:C283($error)
$error:=ws_getCurrencyRate([Currencies:6]ISO4217:31; <>baseCurrency; ->[Currencies:6]ForcedMarketRate:14)
If ($error>0)
	iH_Notify("ERROR"; "Couldn't retreive spot rate for this currency. ["+[Currencies:6]ISO4217:31+"]"; 5)
	
	//myAlert ("Couldn't retreive spot rate for this currency.")
	//[Currencies]SpotRateLocal:=[Currencies]ForcedMarketRate
	//setCurrencyRates 
End if 
OBJECT SET ENABLED:C1123(Self:C308->; True:C214)
