//%attributes = {}


//ARRAY TEXT($anames;0)
//ARRAY TEXT($avalues;0)
//WEB GET VARIABLES($anames;$avalues)


//get session id and determine user

//query selection... as needed

C_TEXT:C284($tContext)
$tContext:=webContext

//problay need to verify we have the correct customer
webSelectCustomerRecord

Case of 
	: ($tContext="customer@")
		If (Records in selection:C76([Customers:3])=1)
			QUERY SELECTION:C341([Bookings:50]; [Bookings:50]CustomerID:2=[Customers:3]CustomerID:1)
		Else 
			REDUCE SELECTION:C351([Bookings:50]; 0)
		End if 
		
	: ($tContext="agent@")
		REDUCE SELECTION:C351([Bookings:50]; 0)
		
	Else 
		REDUCE SELECTION:C351([Bookings:50]; 0)
End case 