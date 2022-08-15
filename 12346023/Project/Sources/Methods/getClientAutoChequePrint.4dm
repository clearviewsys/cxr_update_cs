//%attributes = {}
// getclientAutoChequePrint({ClientName}) -> is portrait:bool
// get current client automatic cheque printing


C_BOOLEAN:C305($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]doPrintChequeAfterSave:27
Else 
	$0:=False:C215
End if 