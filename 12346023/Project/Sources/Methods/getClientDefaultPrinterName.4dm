//%attributes = {}
// getClientReceiptPrinterName({ClientName}) -> printerName
// get current client Default printer name

C_TEXT:C284($0)
selectClientPrefsRecord
If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]defaultPrinterName:4
Else 
	$0:=""
End if 