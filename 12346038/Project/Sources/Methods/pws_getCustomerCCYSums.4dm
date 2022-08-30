//%attributes = {"publishedSoap":true,"publishedWsdl":true,"executedOnServer":true}
// pws_getCustomerCCYBalance (CustomerID;Currency) -> real
// published web service

C_TEXT:C284($1; $customerID)
C_TEXT:C284($2; $currency)
C_REAL:C285(wsDebitBalance; wsCreditBalance)
C_TEXT:C284(wsCustomerName)

If (Count parameters:C259=0)
	$customerID:=""
	$currency:=""
Else 
	$customerID:=$1
	$currency:=$2
End if 

wsDebitBalance:=0
wsCreditBalance:=0
wsCustomerName:=""

SOAP DECLARATION:C782($1; Is text:K8:3; SOAP input:K46:1; "customerID")
SOAP DECLARATION:C782($2; Is text:K8:3; SOAP input:K46:1; "currency")
SOAP DECLARATION:C782(wsDebitBalance; Is real:K8:4; SOAP output:K46:2; "debitSum")
SOAP DECLARATION:C782(wsCreditBalance; Is real:K8:4; SOAP output:K46:2; "creditSum")
SOAP DECLARATION:C782(wsCustomerName; Is text:K8:3; SOAP output:K46:2; "customerName")

READ ONLY:C145([Customers:3])
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID)

If (Records in selection:C76([Customers:3])=1)
	wsCustomerName:=[Customers:3]FullName:40
End if 

READ ONLY:C145([Registers:10])
QUERY:C277([Registers:10]; [Registers:10]CustomerID:5=$customerID; *)
QUERY:C277([Registers:10];  & ; [Registers:10]Currency:19=$currency)

wsDebitBalance:=Sum:C1([Registers:10]Debit:8)
wsCreditBalance:=Sum:C1([Registers:10]Credit:7)
