//%attributes = {}
// getClientReceiptPrinterName({ClientName}) -> printerName
// get current client Cheque printer name

C_TEXT:C284($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]chequePrinterName:2
Else 
	$0:=""
End if 