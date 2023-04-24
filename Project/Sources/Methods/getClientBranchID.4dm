//%attributes = {}
// getClientBranchID({ClientName}) -> is portrait:bool
// get current client automatic cheque printing


C_TEXT:C284($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=Uppercase:C13([ClientPrefs:26]BranchID:32)
Else 
	$0:=""
End if 