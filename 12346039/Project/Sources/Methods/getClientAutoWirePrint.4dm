//%attributes = {}
// getClientAutoWirePrint({ClientName}) -> bool (automatically print?)
// get current client automatic wire printing preference 


C_BOOLEAN:C305($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]doPrintWireAfterSave:29
Else 
	$0:=False:C215
End if 