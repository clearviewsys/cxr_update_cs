//%attributes = {}


//get session id and determine user

//query selection... as needed


C_TEXT:C284($tContext)
$tContext:=webContext



Case of 
	: ($tContext="customer@")
		webSelectCustomerRecord
		
	: ($tContext="agent@")
		webSelectAgentRecord
		
		//what is the current [links] record and get only customers related to that link
		QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Links:17]CustomerID:14)  //should this be query selection???
		
	Else 
		
End case 