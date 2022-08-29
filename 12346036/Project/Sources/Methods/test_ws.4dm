//%attributes = {}

C_REAL:C285($result)

$result:=ws_getAccountBalance("Cash-USD")
myAlert(String:C10($result))

