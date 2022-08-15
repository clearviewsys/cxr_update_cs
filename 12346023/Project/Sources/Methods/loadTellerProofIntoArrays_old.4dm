//%attributes = {}
//  loadTellerProofIntoArrays(currency)
//  this method loads the last tellerproof record for the current user and fills the arrays
//  the arrays in this method are part of the form 

C_TEXT:C284($currency; $tellerProofID; $1)

$currency:=$1

QUERY:C277([TellerProof:78]; [TellerProof:78]Teller:2=getApplicationUser; *)
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]Currency:4=$currency)
ORDER BY:C49([TellerProof:78]; [TellerProof:78]TellerProofID:1)
LAST RECORD:C200([TellerProof:78])  // load the last tellerproof
$tellerProofID:=[TellerProof:78]TellerProofID:1

If (Records in selection:C76([TellerProof:78])>0)
	QUERY:C277([TellerProofLines:79]; [TellerProofLines:79]TellerProofID:1=$tellerProofID)
	orderByTellerProofLines
	C_LONGINT:C283($n)
	$n:=Records in selection:C76([TellerProofLines:79])
	SELECTION TO ARRAY:C260([TellerProofLines:79]Denomination:3; arrDenoms; [TellerProofLines:79]Count1:4; arrQty1; [TellerProofLines:79]Count2:5; arrQty2; [TellerProofLines:79]Total:6; arrTotals)
	ARRAY LONGINT:C221(arrTotalQtys; $n)  // resize the array 
	vAdd(->arrQty1; ->arrQty2; ->arrTotalQtys)  // add the qtys 
End if 
