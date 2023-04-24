//%attributes = {"publishedSoap":true,"publishedWsdl":true}
// pws_getAccountBalances (AccountID) -> real
// publish web service

C_TEXT:C284($1)
ARRAY REAL:C219(myarray; 2)
C_POINTER:C301($0)


SOAP DECLARATION:C782($1; Is text:K8:3; SOAP input:K46:1; "AccountID")
SOAP DECLARATION:C782($0; Real array:K8:17; SOAP output:K46:2; "ArrayOfBalances")

QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$1)
myarray{1}:=Sum:C1([Registers:10]Debit:8)
myarray{2}:=Sum:C1([Registers:10]Credit:7)

$0:=->myArray