If ([Customers:3]isCompany:41)
	vCustomerName:=[Customers:3]FullName:40
Else 
	vCustomerName:=[Customers:3]Salutation:2+" "+[Customers:3]FullName:40
End if 