//%attributes = {}



C_BOOLEAN:C305($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]autoRefreshBrowser:37
Else 
	$0:=False:C215
End if 