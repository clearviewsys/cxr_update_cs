//%attributes = {}
// setCurrencySpotRate (newSpotRate;source)

C_REAL:C285($1; $marketAvg)
C_REAL:C285($oldSpotRate; $newSpotRate; $pctChange)
C_TEXT:C284($2; $source)

$marketAvg:=$1
$source:=$2

If ([Currencies:6]AutoUpdateOurRates:21)
	$oldSpotRate:=[Currencies:6]SpotRateLocal:17  // old adjusted spot rate
	$newSpotRate:=getAdjustedMarketRate($marketAvg)  // new adjusted spot rate
	$pctChange:=calcPctChange($oldSpotRate; $newSpotRate)  // the pct change
	
	If ([Currencies:6]CurrencyCode:1=<>baseCurrency)
		[Currencies:6]SpotRateLocal:17:=1
	Else 
		
		If (($newSpotRate>0) & (Abs:C99($pctChange)<<>maxPCTChangeAllowance))  // the new spot rate must be positive
			
			[Currencies:6]SpotRateLocal:17:=$newSpotRate
			[Currencies:6]oldSpotRate1:44:=$oldSpotRate
			[Currencies:6]pctChange:42:=$pctChange
			[Currencies:6]rateChange:43:=$newSpotRate-$oldSpotRate
			
			[Currencies:6]MarketUpdateTime:19:=Current time:C178  //getYahooUpdateTime ($1)
			[Currencies:6]MarketUpdateDate:18:=Current date:C33  // getYahooUpdateDate ($1)
			[Currencies:6]UpdateSource:20:=$source
			[Currencies:6]hasFailedUpdate:37:=False:C215
			
			setCurrencyRates
		Else 
			[Currencies:6]hasFailedUpdate:37:=True:C214
		End if 
		
	End if 
End if 