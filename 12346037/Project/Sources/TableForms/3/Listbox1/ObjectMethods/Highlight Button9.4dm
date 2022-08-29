CONFIRM:C162("Run query on all records or currenct selection"; "All Records"; "Selection Only")
If (OK=1)
	QUERY:C277([Customers:3]; [Customers:3]isCompany:41=False:C215)
Else 
	QUERY SELECTION:C341([Customers:3]; [Customers:3]isCompany:41=False:C215)
End if 
orderbyCustomers