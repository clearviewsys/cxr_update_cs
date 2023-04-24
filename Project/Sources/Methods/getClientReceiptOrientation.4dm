//%attributes = {}
// getClientReceiptPrinterName({ClientName}) -> is portrait:bool
// get current client receipt orientation

C_BOOLEAN:C305($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]isPrintReceipt_portrait:16
Else 
	$0:=True:C214
End if 