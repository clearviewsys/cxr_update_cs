//%attributes = {}


C_TEXT:C284($tContext)
$tContext:=webContext



Case of 
	: ($tContext="customer@")
		//problay need to verify we have the correct customer
		webSelectCustomerRecord
		
		If (Records in selection:C76([Customers:3])=1)
			QUERY SELECTION:C341([LinkedDocs:4]; [LinkedDocs:4]CustomerID:1=[Customers:3]CustomerID:1)
			
		Else 
			REDUCE SELECTION:C351([LinkedDocs:4]; 0)
		End if 
		
	Else 
		REDUCE SELECTION:C351([LinkedDocs:4]; 0)
End case 