//%attributes = {}
//selectCustomerByID(customerID)
C_TEXT:C284($1)
C_LONGINT:C283($0)

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$1)
$0:=Records in selection:C76([Customers:3])
