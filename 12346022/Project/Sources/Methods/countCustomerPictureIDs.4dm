//%attributes = {}
//countCustomerPictureIDs ({customerID}) ->int

// returns the number of unexpired picture IDs for customer

C_LONGINT:C283($count; $0)
C_TEXT:C284($customerID; $1)

SET QUERY DESTINATION:C396(Into variable:K19:4; $count)
Case of 
	: (Count parameters:C259=0)
		$customerID:=[Customers:3]CustomerID:1
	: (Count parameters:C259=1)
		$customerID:=$1
End case 
QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]CustomerID:1=$customerID; *)
QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]ExpiryDate:4>Current date:C33; *)
QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]ExpiryDate:4#!00-00-00!)
$0:=$count
SET QUERY DESTINATION:C396(Into current selection:K19:1)
