If (Self:C308->=0)
	allRecordsCustomers
Else 
	QUERY:C277([Customers:3]; [Customers:3]KYC_CreditRating:51=Self:C308->-1)
	orderbyCustomers
End if 
POST OUTSIDE CALL:C329(Current process:C322)

