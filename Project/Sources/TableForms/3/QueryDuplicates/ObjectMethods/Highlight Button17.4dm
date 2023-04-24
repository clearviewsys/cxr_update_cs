C_LONGINT:C283(cbQuerySelection)

If (cbQuerySelection=0)
	ALL RECORDS:C47([Customers:3])
End if 

QUERY SELECTION:C341([Customers:3]; [Customers:3]DOB:5>!00-00-00!)

findDuplicateRecordsOn2Fields(->[Customers:3]; ->[Customers:3]FullName:40; ->[Customers:3]DOB:5)
