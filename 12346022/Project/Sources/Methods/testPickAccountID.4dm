//%attributes = {}
C_TEXT:C284($accountID)

$accountID:=""
pickAccountsOfCurrency(->$accountID; "NZD"; "Pick your account")
If (OK=1)
	myAlert($accountID+CRLF+[Accounts:9]AccountType:5+CRLF+[Accounts:9]AccountID:1)
End if 