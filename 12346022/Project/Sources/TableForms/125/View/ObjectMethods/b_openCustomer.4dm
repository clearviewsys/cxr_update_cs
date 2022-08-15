If (Form event code:C388=On Clicked:K2:4)
	relateOne(->[Customers:3]; ->[AML_ReviewLog:125]CustomerID:2; ->[Customers:3]CustomerID:1)
	displaySelectedRecords(->[Customers:3])
End if 