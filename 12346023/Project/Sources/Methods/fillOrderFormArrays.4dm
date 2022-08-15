//%attributes = {}
// fillTellerProofArrays ($Currency;$1)
C_TEXT:C284($currency; $1; vCashAccount)
C_LONGINT:C283($position; $i)

$currency:=$1
VCURRENCY:=$currency
$position:=Find in array:C230(arrCurr; $currency)

If ($position=-1)  // not found
	QUERY:C277([Denominations:31]; [Denominations:31]Currency:2=$currency)
	orderByDenominations
	//SELECTION TO ARRAY([Denominations]Value;arrDenoms)
	
	
	C_LONGINT:C283($n; $m)
	$m:=Size of array:C274(arrCurr)
	$n:=Records in selection:C76([Denominations:31])
	ARRAY BOOLEAN:C223(lbaOrderLines; $n+$m)
	ARRAY LONGINT:C221(arrQty; $n+$m)
	ARRAY REAL:C219(arrTotals; $n+$m)
	ARRAY TEXT:C222(arrCurr; $n+$m)
	ARRAY REAL:C219(arrDenoms; $n+$m)
	
	//loadTellerProofIntoArrays (vCashAccount)
	loadCurrencyOrderIntoArrays($currency)
	FIRST RECORD:C50([Denominations:31])
	For ($i; $m+1; $n+$m)
		GOTO SELECTED RECORD:C245([Denominations:31]; $i-$m)
		arrDenoms{$i}:=[Denominations:31]Value:3
		arrCurr{$i}:=$currency
	End for 
	//listbox_EditFirstRow (->arrQty)
Else 
	//listbox_editCurrentRow ("arrQty";->lbaOrderLines)
	
End if 
