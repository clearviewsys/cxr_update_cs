//%attributes = {}
// getClientReceiptPrinterName({ClientName}) -> printerName
// get current client receipt printer name

C_TEXT:C284($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]receiptPrinterName:3
Else 
	$0:=""
End if 