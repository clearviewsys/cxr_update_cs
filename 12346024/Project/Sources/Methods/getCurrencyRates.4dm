//%attributes = {}
// getCurrencyRates (currency; ->spotrate; ->buyRate;->sellRate)
// POST : Will destroy the currency selection of Currencies table
C_TEXT:C284($1; $currencyCode)
C_POINTER:C301($2; $3; $4)

$currencyCode:=$1

QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$currencyCode)
If (Records in selection:C76([Currencies:6])=1)
	$2->:=[Currencies:6]SpotRateLocal:17
	$3->:=[Currencies:6]OurBuyRateLocal:7
	$4->:=[Currencies:6]OurSellRateLocal:8
Else 
	$2->:=0
	$3->:=0
	$4->:=0
End if 