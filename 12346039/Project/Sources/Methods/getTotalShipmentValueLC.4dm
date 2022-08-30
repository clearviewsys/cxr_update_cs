//%attributes = {}
// getTotalshipmentValueInLC (shipmentID)

C_TEXT:C284($shipmentID; $1; $curr)
$shipmentID:=$1

C_REAL:C285($shipmentValue; $totalshipmentValue; $0)


QUERY:C277([ShipmentLines:98]; [ShipmentLines:98]shipmentID:2=$shipmentID)
ORDER BY:C49([ShipmentLines:98]; [ShipmentLines:98]Curr:3; >)

DISTINCT VALUES:C339([ShipmentLines:98]Curr:3; $ARRCURRENCIES)

SORT ARRAY:C229($ARRCURRENCIES)
C_LONGINT:C283($i; $n)
$n:=Size of array:C274($ARRCURRENCIES)
C_REAL:C285($marketRate; $shipmentAmount)

$shipmentValue:=0
For ($i; 1; $n)
	$curr:=$ARRCURRENCIES{$i}
	
	selectCurrencyByISOCode($curr)
	$marketRate:=[Currencies:6]SpotRateLocal:17
	$shipmentAmount:=getTotalShipmentForCurrency($shipmentID; $curr)
	$shipmentValue:=($shipmentAmount*$marketRate)
	$totalshipmentValue:=$totalshipmentValue+$shipmentValue  // accumulate the 
End for 

ARRAY TEXT:C222($ARRCURRENCIES; 0)
$0:=roundToBase($totalshipmentValue)

