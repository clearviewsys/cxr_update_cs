//%attributes = {}
C_REAL:C285($balance)
C_TEXT:C284($accountID)
$accountID:=Request:C163("Account ID")

$balance:=ws_getAccountBalance($accountID; "lnsp.dynns.com")
myAlert("Balance for "+$accountID+" is "+String:C10($balance))
