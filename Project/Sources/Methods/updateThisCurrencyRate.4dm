//%attributes = {}
// updateThisCurrencyRate 

C_LONGINT:C283($error; $0)
If (([Currencies:6]ISO4217:31#"") & ([Currencies:6]toISO4217:32#""))
	If (<>ClientKey="")
		$error:=ws_getConversionRateOld([Currencies:6]ISO4217:31; [Currencies:6]toISO4217:32; ->[Currencies:6]SpotRateLocal:17)
	Else 
		$error:=ws_getCurrencyRate([Currencies:6]ISO4217:31; [Currencies:6]toISO4217:32; ->[Currencies:6]SpotRateLocal:17)
	End if 
	
	If ($error>0)
		iH_Notify("ERROR"; "Couldn't retreive the rate for this currency. ["+[Currencies:6]CurrencyCode:1+"]"; 5)
		//myAlert("ERROR: Couldn't retreive the rate for this currency.")
		[Currencies:6]hasFailedUpdate:37:=True:C214
	Else 
		
		// adjust the spot rate
		If ([Currencies:6]MarketAdjustCoef:39#0)
			[Currencies:6]SpotRateLocal:17:=([Currencies:6]SpotRateLocal:17*[Currencies:6]MarketAdjustCoef:39)
		End if 
		
		[Currencies:6]SpotRateLocal:17:=[Currencies:6]SpotRateLocal:17+[Currencies:6]MarketAdjusterValue:38
		[Currencies:6]spotRateInverse:41:=calcSafeDivide(1; [Currencies:6]SpotRateLocal:17)
		
		setCurrencyRates
		[Currencies:6]hasFailedUpdate:37:=False:C215
		[Currencies:6]MarketUpdateDate:18:=Current date:C33
		[Currencies:6]MarketUpdateTime:19:=Current time:C178
		
	End if 
Else 
	$0:=0
End if 
$0:=$error