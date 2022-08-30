//%attributes = {}
// getClientDefaultOrientation({ClientName}) -> is portrait:bool
// get current client default orientation

C_BOOLEAN:C305($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]isPrintDefault_portrait:14
Else 
	$0:=True:C214
End if 