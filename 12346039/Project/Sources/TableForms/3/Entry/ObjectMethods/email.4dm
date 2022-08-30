//handleCustomerUniqueFieldOM(Self;->[Customers]CustomerID;"This email already exist. Please make sure this is not a duplicate profile!")
If (Not:C34(isFieldUnique(->[Customers:3]Email:17; ->[Customers:3]CustomerID:1)))
	myAlert("The email <X> already exist in the database. Please make sure this is not a duplicate record"; "Duplicate Record"; [Customers:3]Email:17)
	[Customers:3]Email:17:=""
End if 