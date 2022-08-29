//%attributes = {}
// getClientBranchID({ClientName}) -> is portrait:bool
// get current client automatic cheque printing


C_BOOLEAN:C305($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]doIntegrityChecksAtStartup:35
Else 
	$0:=False:C215
End if 