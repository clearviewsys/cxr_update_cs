//%attributes = {}
// [MainAccounts];"Pick"

C_TEXT:C284($accountID)

$accountID:=""
pickMainAccounts(->$accountID)
If (OK=1)
	myAlert($accountID+CRLF+[MainAccounts:28]AccountType:4)
End if 