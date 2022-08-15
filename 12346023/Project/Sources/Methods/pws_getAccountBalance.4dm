//%attributes = {"publishedSoap":true,"publishedWsdl":true}
// pws_getAccountBalance (AccountID) -> real
// published web service

C_TEXT:C284($1)
C_REAL:C285($0)



SOAP DECLARATION:C782($1; Is text:K8:3; SOAP input:K46:1; "accountID")
SOAP DECLARATION:C782($0; Is real:K8:4; SOAP output:K46:2; "balance")

QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$1)
$0:=Sum:C1([Registers:10]Debit:8)-Sum:C1([Registers:10]Credit:7)
