//createCashInOutSubrecord (vDenomination;0;vQty;vCurrency;vFromCashAccount;vFromTransID)
//createCashInOutSubrecord (vDenomination;vQty;0;vCurrency;vToCashAccount;vToTransID)

C_TEXT:C284($cashTransactionID_From; $cashTransactionID_To)
C_LONGINT:C283($i)

checkInit
validateCashTransfer

If (isValidationConfirmed)
	//starttransaction  // disabled by: Barclay Berry (2/24/13) per Tiran
	$cashTransactionID_From:=createCashTransactionRecord(vDate; vFromCashAccount; vTotalAmount; vCurrency; True:C214; "Transfer"; getSelfCustomerID; vComments)
	$cashTransactionID_To:=createCashTransactionRecord(vDate; vToCashAccount; vTotalAmount; vCurrency; False:C215; "Transfer"; getSelfCustomerID; vComments)
	For ($i; 1; Size of array:C274(arrQty))
		createCashInOutSubrecord(arrDenomination{$i}; 0; arrQty{$i}; vCurrency; vFromCashAccount; $cashTransactionID_From)
		createCashInOutSubrecord(arrDenomination{$i}; arrQty{$i}; 0; vCurrency; vToCashAccount; $cashTransactionID_To)
	End for 
	//validatetransaction  // disabled by: Barclay Berry (2/24/13) per Tiran
	ACCEPT:C269
Else 
	REJECT:C38
End if 
