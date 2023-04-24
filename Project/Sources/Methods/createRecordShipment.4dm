//%attributes = {}
// createRecordshipment (shipmentID;$notes)


C_TEXT:C284($shipmentID; $1; $notes; $2)
C_LONGINT:C283($status; $3)

$shipmentID:=$1
$notes:=$2
$status:=$3

CREATE RECORD:C68([Shipments:97])

[Shipments:97]fromBranchID:2:=getBranchID

[Shipments:97]shipmentID:1:=$shipmentID
[Shipments:97]shipmentDate:3:=Current date:C33
[Shipments:97]shipmentTime:4:=Current time:C178
[Shipments:97]shippedBy:9:=getApplicationUser
[Shipments:97]shippingStatus:8:=$status

[Shipments:97]shippingNotes:11:=$notes
SAVE RECORD:C53([Shipments:97])

UNLOAD RECORD:C212([Shipments:97])
