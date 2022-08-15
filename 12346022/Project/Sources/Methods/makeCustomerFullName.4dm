//%attributes = {}
If ([Customers:3]isCompany:41)
	[Customers:3]FullName:40:=[Customers:3]CompanyName:42
Else 
	[Customers:3]FullName:40:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
End if 
