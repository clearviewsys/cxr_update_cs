//%attributes = {}
// selecteWiresForCustomer(customerID)

// POST: ewires and Links selection will be modified
READ ONLY:C145([eWires:13])
If ($1#"")
	QUERY:C277([eWires:13]; [eWires:13]CustomerID:15=$1)
	
Else 
	ALL RECORDS:C47([eWires:13])
End if 
ORDER BY:C49([eWires:13]; [eWires:13]eWireID:1; <)