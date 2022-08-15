//%attributes = {}
// createRecordOrderLines (orderID;curr;denom;qty)
C_TEXT:C284($orderID; $1)
C_TEXT:C284($curr; $2)
C_REAL:C285($denom; $3)

C_LONGINT:C283($qty; $4)

$orderID:=$1
$curr:=$2
$denom:=$3
$qty:=$4

CREATE RECORD:C68([OrderLines:96])
[OrderLines:96]orderID:2:=$orderID
[OrderLines:96]denomination:4:=$denom
[OrderLines:96]Curr:3:=$curr
[OrderLines:96]QtyOrdered:5:=$qty
SAVE RECORD:C53([OrderLines:96])
UNLOAD RECORD:C212([OrderLines:96])