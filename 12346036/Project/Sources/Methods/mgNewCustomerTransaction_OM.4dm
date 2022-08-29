//%attributes = {}
// mgNewCustomerTransaction_OM (TransactionType: {Send/Receive} ; credentials: object {username; agentID; password})
// this method creates a send object and open a form for sending and receiving

C_TEXT:C284($1; $transactionType)
C_OBJECT:C1216($3; $credentials)
C_TEXT:C284($2; $customerID)
C_OBJECT:C1216($transaction; $customer)

$transactionType:=$1
$customerID:=$2

$customer:=ds:C1482.Customers.query("CustomerID = :1"; $customerID).first()

If (Count parameters:C259>2)
	$credentials:=$3
End if 

$transaction:=mgNewTransactionByCustomer($transactionType; $customer)

If ($transaction#Null:C1517)
	
	$transaction.credentials:=$credentials
	
	mgDisplayDialog($transaction)
	
End if 
