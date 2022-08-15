//%attributes = {}
C_TEXT:C284(theCustomerID)

If (Count parameters:C259=1)
	theCustomerID:=$1
	//Else 
	//theCustomerID:=""
End if 

QUERY:C277([Links:17]; [Links:17]CustomerID:14=theCustomerID; *)
QUERY:C277([Links:17];  | ; [Links:17]CustomerID:14="")