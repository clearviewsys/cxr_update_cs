//%attributes = {"publishedWeb":true}
// getMarketAvgRate(ticker)

// returns the market average

// PRE: ticker must be in the database


C_TEXT:C284($1)
C_REAL:C285($0)

CREATE SET:C116([Currencies:6]; "$tempcurr")
QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$1)
If (Records in selection:C76([Currencies:6])=1)
	$0:=[Currencies:6]SpotRateLocal:17
Else 
	$0:=0
End if 
USE SET:C118("$tempCurr")
CLEAR SET:C117("$tempCurr")