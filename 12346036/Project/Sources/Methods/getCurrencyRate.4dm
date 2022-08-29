//%attributes = {}
// getCurrencyRate (CCY) : returns the direct market rate for the currency in Local Currency
// this method doesn't change the selection of record

C_TEXT:C284($currency; $1)
C_REAL:C285($0; $rate)

Case of 
	: (Count parameters:C259=0)
		$currency:="USD"
	: (Count parameters:C259=1)
		$currency:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

COPY NAMED SELECTION:C331([Currencies:6]; "$curr")
READ ONLY:C145([Currencies:6])
QUERY:C277([Currencies:6]; [Currencies:6]ISO4217:31=$currency)

$rate:=[Currencies:6]SpotRateLocal:17  // market rate
USE NAMED SELECTION:C332("$curr")
CLEAR NAMED SELECTION:C333("$curr")

//Begin SQL
//SELECT Currencies.Spotratelocal FROM Currencies WHERE Currencies.ISO4217=:$currency
//Into :$rate
//End SQL

$0:=$rate