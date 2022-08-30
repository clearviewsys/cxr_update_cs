//%attributes = {}
// getOurBuyRate(ticker)

// returns the market average

// PRE: ticker must be in the database


C_TEXT:C284($1)
C_POINTER:C301($2; $3; $4)

CREATE SET:C116([Currencies:6]; "$tempcurr")
QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$1)
If (Records in selection:C76([Currencies:6])=1)
	$2->:=[Currencies:6]OurBuyRateLocal:7
	$3->:=[Currencies:6]OurSellRateLocal:8
	$4->:=[Currencies:6]SpotRateLocal:17
Else 
	$2->:=0
	$3->:=0
	$4->:=0
End if 
USE SET:C118("$tempCurr")
CLEAR SET:C117("$tempCurr")