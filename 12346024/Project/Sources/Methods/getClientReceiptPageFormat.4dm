//%attributes = {}
// getClientReceiptPaperFormat({ClientName}) -> paper format
// get current client Receipt paper format/name

C_TEXT:C284($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]receiptPageFormat:19
Else 
	$0:=""
End if 