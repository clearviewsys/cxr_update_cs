//%attributes = {}
//C_TEXT($subaccounts;$accountID)
//$accountID:="Account-USD"
//pickSubAccounts (->$subaccounts;$accountID)

//myAlert ($subaccounts)
C_TEXT:C284($pickedSubaccounts)
C_BOOLEAN:C305($0; $success)

// form name: ([Subaccounts];"Pick")

pickSubAccounts(->$pickedSubaccounts)

If (OK=1)
	myAlert($pickedSubaccounts)
Else 
	myAlert("Canceled")
End if 

//confirmTestPassed(->$success)

$0:=$success