//%attributes = {}
C_TEXT:C284(theCustomerID)

If (Count parameters:C259=1)
	theCustomerID:=$1
End if 
QUERY:C277([WireTemplates:42]; [WireTemplates:42]CustomerID:2=theCustomerID; *)
QUERY:C277([WireTemplates:42];  | ; [WireTemplates:42]CustomerID:2="")