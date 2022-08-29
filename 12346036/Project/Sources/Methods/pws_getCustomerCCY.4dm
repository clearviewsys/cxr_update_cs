//%attributes = {"publishedSoap":true,"publishedWsdl":true,"executedOnServer":true}
// pws_getCustomerCCY (CustomerID;Currency) -> real
// published web service

C_TEXT:C284($1; $customerID)
C_TEXT:C284($2; $currency)
C_REAL:C285($0; $balance)

If (Count parameters:C259=0)
	$customerID:=""
	$currency:=""
Else 
	$customerID:=$1
	$currency:=$2
End if 
$balance:=0

SOAP DECLARATION:C782($1; Is text:K8:3; SOAP input:K46:1; "customerID")
SOAP DECLARATION:C782($2; Is text:K8:3; SOAP input:K46:1; "currency")
SOAP DECLARATION:C782($0; Is real:K8:4; SOAP output:K46:2; "balance")

READ ONLY:C145([Registers:10])
QUERY:C277([Registers:10]; [Registers:10]CustomerID:5=$customerID; *)
QUERY:C277([Registers:10];  & ; [Registers:10]Currency:19=$currency)

$balance:=Sum:C1([Registers:10]Debit:8)-Sum:C1([Registers:10]Credit:7)
$0:=$balance
