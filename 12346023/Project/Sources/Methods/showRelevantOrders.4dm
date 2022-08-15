//%attributes = {}


If (isUserAdministrator)
	QUERY:C277([Orders:95]; [Orders:95]orderStatus:11=1)
Else 
	QUERY:C277([Orders:95]; [Orders:95]orderedBy:3=getApplicationUser)
End if 

orderByOrders
