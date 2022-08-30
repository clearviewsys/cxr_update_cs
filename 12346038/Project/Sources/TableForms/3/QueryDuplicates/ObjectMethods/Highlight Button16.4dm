C_LONGINT:C283(cbQuerySelection)

If (cbQuerySelection=0)
	ALL RECORDS:C47([Customers:3])
End if 

findDuplicateRecords(->[Customers:3]; ->[Customers:3]CustomerID:1)
