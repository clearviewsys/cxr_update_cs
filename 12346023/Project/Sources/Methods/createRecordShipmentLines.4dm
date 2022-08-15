//%attributes = {}
// createRecordshipmentLines (shipmentID;curr;denom;qty)
C_TEXT:C284($shipmentID; $1)
C_TEXT:C284($curr; $2)
C_REAL:C285($denom; $3)

C_LONGINT:C283($qty; $4)

$shipmentID:=$1
$curr:=$2
$denom:=$3
$qty:=$4

CREATE RECORD:C68([ShipmentLines:98])
[ShipmentLines:98]shipmentID:2:=$shipmentID
[ShipmentLines:98]denomination:4:=$denom
[ShipmentLines:98]Curr:3:=$curr
[ShipmentLines:98]QtyShipped:5:=$qty
SAVE RECORD:C53([ShipmentLines:98])
UNLOAD RECORD:C212([ShipmentLines:98])