//%attributes = {}
//  loadTellerProofIntoArrays(currency)
//  this method loads the last tellerproof record for the current user and fills the arrays
//  the arrays in this method are part of the form 

C_TEXT:C284($cashAccount; $tellerProofID)
C_LONGINT:C283($n)


$cashAccount:=$1

QUERY:C277([TellerProof:78]; [TellerProof:78]CashAccountID:3=$cashAccount; *)  // search for the cash-account because we want to follow the cash account, not the user and currency
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]BranchID:13=getBranchID)  // added in version 4.305 by TB on Jan 8 2015 to prevent the problem of loading a TP from another branch


// it means when a user logs off from a till and logs in to another till, we want to load the tellerproof that was available in the new till 


ORDER BY:C49([TellerProof:78]; [TellerProof:78]Date:10; >; [TellerProof:78]TellerProofID:1; >)  // changed by TB on Feb 26, 2019

LAST RECORD:C200([TellerProof:78])  // load the last tellerproof

// loading the last teller proof can create a little bit of a program . 
// since in a multibranch situation the teller proof for another branch that
// has a higher Prefix get selected... .this NEEDS TO BE ADDRESSED
// WE CANNOT ASSUME THAT THE TELLERPROOFIDS ARE ALL SEQUENTIAL
// WE SHOULD QUERY BY DATE AND TIME OR ANOTHER SERIAL NUMBER. '
// NOTE: THIS ISSUE HAS BEEN ADDRESSED IN THE QUERY BY BRANCH ID but not thoroughly tested in version 4.305


$tellerProofID:=[TellerProof:78]TellerProofID:1

If (Records in selection:C76([TellerProof:78])>0)
	QUERY:C277([TellerProofLines:79]; [TellerProofLines:79]TellerProofID:1=$tellerProofID)
	orderByTellerProofLines
	$n:=Records in selection:C76([TellerProofLines:79])
	SELECTION TO ARRAY:C260([TellerProofLines:79]Denomination:3; arrDenoms; [TellerProofLines:79]Count1:4; arrQty1; [TellerProofLines:79]Count2:5; arrQty2; [TellerProofLines:79]Total:6; arrTotals)
	ARRAY LONGINT:C221(arrTotalQtys; $n)  // resize the array 
	vAdd(->arrQty1; ->arrQty2; ->arrTotalQtys)  // add the qtys 
	
Else   // TELLER PROOF LINES WERE NOT FOUND SO INITIALIZE THE ARRAYS AND LISTBOX
	$n:=Records in selection:C76([Denominations:31])
	ARRAY BOOLEAN:C223(lbTellerProof; 0)
	ARRAY LONGINT:C221(arrQty1; 0)
	ARRAY LONGINT:C221(arrQty2; 0)
	ARRAY LONGINT:C221(arrTotalQtys; 0)
	ARRAY REAL:C219(arrTotals; 0)
	
	ARRAY BOOLEAN:C223(lbTellerProof; $n)
	ARRAY LONGINT:C221(arrQty1; $n)
	ARRAY LONGINT:C221(arrQty2; $n)
	ARRAY LONGINT:C221(arrTotalQtys; $n)
	ARRAY REAL:C219(arrTotals; $n)
	
	
End if 
