//%attributes = {}
//createCashInOutSubRecord(Denomination;QtyIn;QtyOut;{currency;{cashAccountID;{cashTransactionID}}})

// create a subrecord in the cashinout table


READ WRITE:C146([CashInOuts:32])

CREATE RECORD:C68([CashInOuts:32])
C_REAL:C285($denom; $1)
C_TEXT:C284($currency; $4)
C_TEXT:C284($cashAccountID; $5; $cashTransactionID; $6)
C_LONGINT:C283($qtyIn; $qtyOut; $2; $3)

$denom:=$1
$qtyIn:=$2
$qtyOut:=$3
$currency:=[CashTransactions:36]Currency:4
$cashAccountID:=[CashTransactions:36]CashAccountID:9
$cashTransactionID:=[CashTransactions:36]CashTransactionID:1

Case of 
	: (Count parameters:C259=4)
		$currency:=$4
	: (Count parameters:C259=5)
		$currency:=$4
		$cashAccountID:=$5
	: (Count parameters:C259=6)
		$currency:=$4
		$cashAccountID:=$5
		$cashTransactionID:=$6
End case 

[CashInOuts:32]CashTransactionID:1:=$cashTransactionID
[CashInOuts:32]Denomination:7:=$denom
[CashInOuts:32]Currency:6:=$currency

[CashInOuts:32]DenominationID:5:=makeDenominationsID($currency; $denom)
[CashInOuts:32]QtyIN:8:=$qtyIn
[CashInOuts:32]QtyOut:9:=$QtyOut
[CashInOuts:32]CashAccountID:4:=$cashAccountID

SAVE RECORD:C53([CashInOuts:32])
UNLOAD RECORD:C212([CashInOuts:32])
//READ ONLY([CashInOuts])` this will prevent editing the Qty field in the subform