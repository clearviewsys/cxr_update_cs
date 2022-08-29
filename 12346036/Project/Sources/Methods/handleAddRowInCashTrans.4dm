//%attributes = {}
// handleAddRowInCashTrans ({isPaid;currency;cashAccountID;CashTransactionID})

C_BOOLEAN:C305($1; $isPaid)
C_TEXT:C284($currency; $cashAccountID; $cashTransactionID)
If (vQty>0)
	$isPaid:=[CashTransactions:36]isPaid:2
Else 
	$isPaid:=Not:C34([CashTransactions:36]isPaid:2)
End if 
$currency:=[CashTransactions:36]Currency:4
$cashAccountID:=[CashTransactions:36]CashAccountID:9
$cashTransactionID:=[CashTransactions:36]CashTransactionID:1

Case of 
	: (Count parameters:C259=4)
		$isPaid:=$1
		$currency:=$2
		$cashAccountID:=$3
		$cashTransactionID:=$4
End case 

C_REAL:C285(vDenomination; vRemaining)
C_LONGINT:C283(vQty)

If (isDenominationKnown($currency; vDenomination))
	
	// Modified by: Tiran Behrouz (5/30/13)
	If ((vDenomination>0) & (vQty#0))  // qty cannot be zero and denomination must be greater than zero
		If ($isPaid)
			createCashInOutSubrecord(vDenomination; 0; Abs:C99(vQty); $currency; $cashAccountID; $cashTransactionID)
		Else 
			createCashInOutSubrecord(vDenomination; Abs:C99(vQty); 0; $currency; $cashAccountID; $cashTransactionID)
		End if 
		vQty:=0
		vDenomination:=0
		vTotal:=0
	End if 
	relateManyCashInOuts
	GOTO OBJECT:C206(*; "vQty")
	
End if 