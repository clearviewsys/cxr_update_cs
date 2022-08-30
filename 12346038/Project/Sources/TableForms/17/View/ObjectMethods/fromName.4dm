
pickCustomer(Self:C308)
RELATE ONE:C42([Links:17]CustomerID:14)
[Links:17]CustomerName:15:=[Customers:3]FullName:40  // then rewrite the correct name on top 
If ([Customers:3]FullName:40#[Links:17]UnconfirmedCustomerName:18)
	BEEP:C151  // customer name is different from the unconfirmed customer name
End if 
POST OUTSIDE CALL:C329(Current process:C322)
