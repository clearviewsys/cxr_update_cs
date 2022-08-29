//%attributes = {}
//getreceiptPageFormat -> int
// returns the scaling percentage for receipt formats

C_TEXT:C284($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]receiptPageFormat:19
Else 
	$0:=""
End if 