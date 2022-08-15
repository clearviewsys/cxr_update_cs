//%attributes = {}
// getOurBuyRate(ticker)

// returns the market average

// PRE: ticker must be in the database


C_TEXT:C284($1)
C_REAL:C285($0)

If (True:C214)
	C_OBJECT:C1216($entity)
	$entity:=New object:C1471
	
	$entity:=ds:C1482.Currencies.query("CurrencyCode == :1"; $1)
	
	If ($entity.length=1)
		$0:=$entity.first().OurBuyRateLocal
	Else 
		$0:=0
	End if 
	
Else 
	CREATE SET:C116([Currencies:6]; "$tempcurr")
	QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$1)
	If (Records in selection:C76([Currencies:6])=1)
		$0:=[Currencies:6]OurBuyRateLocal:7
	Else 
		$0:=0
	End if 
	USE SET:C118("$tempCurr")
	CLEAR SET:C117("$tempCurr")
End if 