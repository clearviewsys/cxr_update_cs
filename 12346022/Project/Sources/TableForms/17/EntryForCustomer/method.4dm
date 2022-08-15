setApplicationUserForTable(->[Links:17]; ->[Links:17]TouchedByUserID:24; ->[Links:17]TouchedByUserID:24)

If (Form event code:C388=On Load:K2:1)
	[Links:17]CustomerID:14:=vCustomerID
	RELATE ONE:C42([Links:17]CustomerID:14)
	[Links:17]CustomerName:15:=[Customers:3]FullName:40
End if 
