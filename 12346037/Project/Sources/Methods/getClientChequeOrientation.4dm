//%attributes = {}
// getClientChequeOrientation({ClientName}) -> is portrait:bool
// get current client Cheque orientation

C_BOOLEAN:C305($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]isPrintCheque_portrait:15
Else 
	$0:=True:C214
End if 