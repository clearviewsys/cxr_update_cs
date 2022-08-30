
CONFIRM:C162("Run query on all records or currenct selection"; "All Records"; "Selection Only")
If (OK=1)
	QUERY:C277([Customers:3]; [Customers:3]PictureID_ExpiryDate:71<=Current date:C33; *)
	QUERY:C277([Customers:3];  & ; [Customers:3]PictureID_ExpiryDate:71>!00-00-00!)
	
Else 
	QUERY SELECTION:C341([Customers:3]; [Customers:3]PictureID_ExpiryDate:71<=Current date:C33; *)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]PictureID_ExpiryDate:71>!00-00-00!)
	
End if 
orderbyCustomers