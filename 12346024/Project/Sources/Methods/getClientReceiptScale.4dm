//%attributes = {}
// getClientReceiptScale({ClientName}) -> scale %
// get current client Receipt printer scale (%)

C_LONGINT:C283($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]receiptPrintScale:22
Else 
	$0:=100
End if 