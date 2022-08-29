//%attributes = {}

// PRE: vCurrency and vCashAccount must be precalculated; and so must vSumTotals (
C_TEXT:C284($notes; $orderID)
C_LONGINT:C283($status; $1)
C_TEXT:C284($notes; $2)

$status:=$1
$notes:=$2

START TRANSACTION:C239

TM_Add2Stack(->[Orders:95]; Current method name:C684; Transaction level:C961)

READ WRITE:C146([Orders:95])
$orderID:=makeorderID
createRecordOrder($orderID; $notes; $status)
C_LONGINT:C283($i)

READ WRITE:C146([OrderLines:96])
For ($i; 1; Size of array:C274(arrCurr))
	createRecordOrderLines($orderID; arrCurr{$i}; arrDenoms{$i}; ARRQTY{$i})
End for 

VALIDATE TRANSACTION:C240

TM_RemoveFromStack

//READ ONLY([TellerProof])
//READ ONLY([TellerProofLines])