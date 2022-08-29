//%attributes = {}
// createRecordOrder (orderID;$notes)


C_TEXT:C284($orderID; $1; $notes; $2)
C_LONGINT:C283($status; $3)

$orderID:=$1
$notes:=$2
$status:=$3

CREATE RECORD:C68([Orders:95])

[Orders:95]branchID:2:=getBranchID

[Orders:95]orderID:1:=$orderID
[Orders:95]orderDate:4:=Current date:C33
[Orders:95]orderTime:5:=Current time:C178
[Orders:95]orderedBy:3:=getApplicationUser
[Orders:95]orderStatus:11:=$status

[Orders:95]orderNotes:6:=$notes
SAVE RECORD:C53([Orders:95])

UNLOAD RECORD:C212([Orders:95])
