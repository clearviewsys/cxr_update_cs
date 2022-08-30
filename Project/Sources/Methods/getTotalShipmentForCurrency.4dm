//%attributes = {}
// getTotalshipmentForCurrency (shipmentId; curr) : real
// returns the sum of the shipment of a certain currency

C_REAL:C285($0)

C_TEXT:C284($shipmentID; $1; $curr; $2)

$shipmentID:=$1
$curr:=$2

QUERY:C277([ShipmentLines:98]; [ShipmentLines:98]shipmentID:2=$shipmentID; *)
QUERY:C277([ShipmentLines:98];  & ; [ShipmentLines:98]Curr:3=$curr)

$0:=Sum:C1([ShipmentLines:98]shipmentValue:6)
