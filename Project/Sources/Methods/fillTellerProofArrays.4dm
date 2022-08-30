//%attributes = {}
// fillTellerProofArrays ($Currency;$1)
C_TEXT:C284($currency; $1; vCashAccount)

$currency:=$1
VCURRENCY:=$currency

selectCashAccountsForUser($currency)

If (Records in selection:C76([Accounts:9])>0)
	vCashAccount:=[Accounts:9]AccountID:1
	
	QUERY:C277([Denominations:31]; [Denominations:31]Currency:2=$currency)
	orderByDenominations
	SELECTION TO ARRAY:C260([Denominations:31]Value:3; arrDenoms)
	
	
	C_LONGINT:C283($n)
	$n:=Records in selection:C76([Denominations:31])
	ARRAY BOOLEAN:C223(lbTellerProof; $n)
	ARRAY LONGINT:C221(arrQty1; $n)
	ARRAY LONGINT:C221(arrQty2; $n)
	ARRAY LONGINT:C221(arrTotalQtys; $n)
	ARRAY REAL:C219(arrTotals; $n)
	
	loadTellerProofIntoArrays(vCashAccount)
	listbox_EditFirstRow(->arrQty1)
Else 
	myAlert("No valid account found. Make sure you are signed in with a till.")
End if 
