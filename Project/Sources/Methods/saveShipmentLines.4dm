//%attributes = {}

// PRE: vCurrency and vCashAccount must be precalculated; and so must vSumTotals (
C_TEXT:C284($notes; $shipmentID)
C_LONGINT:C283($status; $1)
C_TEXT:C284($notes; $2)

$status:=$1
$notes:=$2

START TRANSACTION:C239

TM_Add2Stack(->[ShipmentLines:98]; Current method name:C684; Transaction level:C961)

READ WRITE:C146([Shipments:97])
$shipmentID:=makeshipmentID
createRecordShipment($shipmentID; $notes; $status)

C_LONGINT:C283($i)

READ WRITE:C146([ShipmentLines:98])
For ($i; 1; Size of array:C274(arrCurr))
	createRecordShipmentLines($shipmentID; arrCurr{$i}; arrDenoms{$i}; ARRQTY{$i})
End for 

VALIDATE TRANSACTION:C240

TM_RemoveFromStack