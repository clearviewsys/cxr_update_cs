CONFIRM:C162("Run query on all records or currenct selection"; "All Records"; "Selection Only")
If (OK=1)
	QUERY:C277([Customers:3]; [Customers:3]isOnHold:52=True:C214)
Else 
	QUERY SELECTION:C341([Customers:3]; [Customers:3]isOnHold:52=True:C214)
End if 
orderbyCustomers