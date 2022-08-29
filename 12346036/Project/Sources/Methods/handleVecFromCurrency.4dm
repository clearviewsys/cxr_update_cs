//%attributes = {}
//

//

//QUERY([Currencies];[Currencies]CurrencyCode=[Invoices]BuyCurrencyCode)

//vFromMarketAvg:=[Currencies]MarketAvgLocal

//vFromOurBuy:=[Currencies]OurBuyRateLocal

//

//C_REAL(vRate1)

//vRate1:=[Currencies]MarketAvgLocal

// handleVecCurrency(currencyCode;->marketAvgLocal;->OurBuyRateLocal;->selectedRate)

C_TEXT:C284($1)
C_POINTER:C301($2; $3; $4)
If ($1=<>baseCurrency)
	$2->:=1
	$3->:=1
	$4->:=1
Else 
	QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$1)
	$2->:=[Currencies:6]SpotRateLocal:17
	$3->:=[Currencies:6]OurBuyRateLocal:7
	$4->:=[Currencies:6]SpotRateLocal:17
End if 