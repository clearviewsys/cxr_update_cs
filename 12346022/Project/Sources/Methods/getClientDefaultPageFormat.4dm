//%attributes = {}
// getClientDefaultPaperFormat({ClientName}) -> paper format
// get current client Default paper format/name

C_TEXT:C284($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]defaultPageFormat:17
Else 
	$0:=""
End if 