//%attributes = {}
// getAdjustedMarketRate (marketRate)-> adjustedMarketRate
// PRE: CURRENCY RECORD MUST BE SELECTED FIRST

C_REAL:C285($1; $0; $marketRate; $adjustedRate; $marketCoef; $marketOffset)
$marketRate:=$1

If ([Currencies:6]MarketAdjustCoef:39=0)
	$marketCoef:=1
Else 
	$marketCoef:=[Currencies:6]MarketAdjustCoef:39
End if 

$adjustedRate:=($marketRate*$marketCoef)+[Currencies:6]MarketAdjusterValue:38

$0:=$adjustedRate
