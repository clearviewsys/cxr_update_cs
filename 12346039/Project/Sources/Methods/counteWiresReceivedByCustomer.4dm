//%attributes = {}
C_TEXT:C284($1; $customerID)
C_LONGINT:C283($0; $count)

$customerID:=$1
$0:=selecteWiresReceivedByCustomer($customerID; 1)