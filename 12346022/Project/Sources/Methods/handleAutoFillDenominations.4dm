//%attributes = {}
// handleAutoFillDenominations (amount;currency; ->resultdenomField; ->resultQtyField)

C_REAL:C285($amount; $1)
C_TEXT:C284($transactionID; $currency; $2)
C_POINTER:C301($denomFieldPtr; $resultFieldPtr; $3; $4)

$transactionID:=[CashTransactions:36]CashTransactionID:1
$amount:=$1
$currency:=$2

$denomFieldPtr:=$3
$resultFieldPtr:=$4


C_LONGINT:C283($n; $i)
QUERY:C277([Denominations:31]; [Denominations:31]Currency:2=$currency)
orderByDenominations
$n:=Records in selection:C76([Denominations:31])

ARRAY TEXT:C222(indexArr; $n)

For ($i; 1; $n)  // fill in the array with the fixed transaction ID number (so that the cashinout subrecords are related to the same cas trasaction)
	indexArr{$i}:=$transactionID
End for 
If ($n>0)
	ARRAY REAL:C219($denomArr; $n)
	SELECTION TO ARRAY:C260([Denominations:31]Value:3; $denomArr)
	ARRAY REAL:C219($resultArr; $n)
	breakAmountIntoDenoms($amount; ->$denomArr; ->$resultArr)
	ARRAY TO SELECTION:C261($denomArr; $denomFieldPtr->; $resultArr; $resultFieldPtr->; indexArr; [CashInOuts:32]CashTransactionID:1)
	
End if 

//CLEAR VARIABLE(denomArr)
//CLEAR VARIABLE(resultArr)
