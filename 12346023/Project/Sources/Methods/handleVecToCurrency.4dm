//%attributes = {}
// handleVecCurrency(currencyCode;->marketAvgLocal;->OurBuyRateLocal;->selectedRate)

C_TEXT:C284($1)
C_POINTER:C301($2; $3; $4)
C_REAL:C285($vOurSellRate)
QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$1)
$2->:=[Currencies:6]SpotRateLocal:17
If ([Currencies:6]AutoUpdateOurRates:21=True:C214)
	$vOursellRate:=calcOurSellRate([Currencies:6]SpotRateLocal:17; [Currencies:6]OffsetMarketSell:10; [Currencies:6]AddPctToMarketSell:12)
Else 
	$vOursellRate:=[Currencies:6]OurSellRateLocal:8
End if 
$3->:=$vOurSellRate

$4->:=$vOurSellRate