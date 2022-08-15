//%attributes = {}
// getTotalOrderValueInLC (orderID)

C_TEXT:C284($orderID; $1; $curr)
$orderID:=$1

C_REAL:C285($orderValue; $totalOrderValue; $0)


QUERY:C277([OrderLines:96]; [OrderLines:96]orderID:2=$orderID)
ORDER BY:C49([OrderLines:96]; [OrderLines:96]Curr:3; >)

DISTINCT VALUES:C339([OrderLines:96]Curr:3; $ARRCURRENCIES)

SORT ARRAY:C229($ARRCURRENCIES)
C_LONGINT:C283($i; $n)
$n:=Size of array:C274($ARRCURRENCIES)
C_REAL:C285($marketRate; $orderAmount)

$orderValue:=0
For ($i; 1; $n)
	$curr:=$ARRCURRENCIES{$i}
	
	selectCurrencyByISOCode($curr)
	$marketRate:=[Currencies:6]SpotRateLocal:17
	$orderAmount:=getTotalOrderForCurrencyByOrder($orderID; $curr)
	$orderValue:=($orderAmount*$marketRate)
	$totalOrderValue:=$totalOrderValue+$orderValue  // accumulate the 
End for 

ARRAY TEXT:C222($ARRCURRENCIES; 0)
$0:=roundToBase($totalOrderValue)

