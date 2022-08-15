//%attributes = {}
// getClientChequePaperFormat({ClientName}) -> paper format
// get current client Cheque paper format/name

C_TEXT:C284($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]chequePageFormat:18
Else 
	$0:=""
End if 