//%attributes = {}
// createBaseCurrency
// PRE: This procedure must be called after the importFlags and after assignCompanyVars
// PRE : ◊baseCurrency must be defined

READ ONLY:C145([Flags:19])
QUERY:C277([Flags:19]; [Flags:19]CurrencyCode:1=<>baseCurrency)
If (Records in selection:C76([Flags:19])=1)
	LOAD RECORD:C52([Flags:19])
	QUERY:C277([Currencies:6]; [Currencies:6]ISO4217:31=[Flags:19]CurrencyCode:1)
	If (Records in selection:C76([Currencies:6])=0)
		READ WRITE:C146([Currencies:6])
		CREATE RECORD:C68([Currencies:6])
		[Currencies:6]Flag:3:=[Flags:19]flag:4
		[Currencies:6]CurrencyCode:1:=[Flags:19]CurrencyCode:1
		[Currencies:6]ISO4217:31:=[Flags:19]CurrencyCode:1
		[Currencies:6]toISO4217:32:=[Flags:19]CurrencyCode:1
		[Currencies:6]Name:2:=[Flags:19]CurrencyName:2
		[Currencies:6]Country:22:=[Flags:19]Country:3
		
		[Currencies:6]AutoUpdateOurRates:21:=False:C215
		[Currencies:6]hasCashAccount:23:=True:C214
		[Currencies:6]hasChequeAccount:24:=False:C215
		[Currencies:6]weBuyCoins:47:=True:C214
		[Currencies:6]weSellCoins:48:=True:C214
		
		//[Currencies]MarketSellLocal:=1
		//[Currencies]MarketBuyLocal:=1
		[Currencies:6]SpotRateLocal:17:=1
		
		[Currencies:6]OurBuyRateInverse:25:=1
		[Currencies:6]OurSellRateInverse:26:=1
		[Currencies:6]OurBuyRateLocal:7:=1
		[Currencies:6]OurSellRateLocal:8:=1
		
		[Currencies:6]RoundDigit:27:=0
		[Currencies:6]RoundDigitInverse:28:=0
		[Currencies:6]RoundLowestDenom:13:=<>roundDigitBaseCurrency
		
		SAVE RECORD:C53([Currencies:6])
		UNLOAD RECORD:C212([Currencies:6])
		READ ONLY:C145([Currencies:6])
	End if 
End if 

