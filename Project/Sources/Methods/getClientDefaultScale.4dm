//%attributes = {}
// getClientDefaultScale({ClientName}) -> scale %
// get current client Default printer scale (%)

C_LONGINT:C283($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]defaultPrintScale:20
Else 
	$0:=100
End if 