//%attributes = {}

// PRE: vCurrency and vCashAccount must be precalculated; and so must vSumTotals (
C_TEXT:C284($tellerProofID)
START TRANSACTION:C239

TM_Add2Stack(->[TellerProofLines:79]; Current method name:C684; Transaction level:C961)

READ WRITE:C146([TellerProof:78])
$tellerProofID:=makeTellerProofID
createRecordTellerProof($tellerProofID; vCurrency; vCashAccount; vSumTotals; (cbValidate=1))
C_LONGINT:C283($i)
READ WRITE:C146([TellerProofLines:79])
For ($i; 1; Size of array:C274(arrDenoms))
	createRecordTellerProofLines($tellerProofID; arrDenoms{$i}; vCurrency; arrQty1{$i}; arrQty2{$i})
End for 

VALIDATE TRANSACTION:C240

TM_RemoveFromStack

//READ ONLY([TellerProof])
//READ ONLY([TellerProofLines])