//%attributes = {"shared":true}

C_TEXT:C284($tContext)


$tContext:=webContext



Case of 
	: ($tContext="customer@")
		//problay need to verify we have the correct customer
		webSelectCustomerRecord
		
		If (Records in selection:C76([Customers:3])=1)
			QUERY SELECTION:C341([WebAttachments:86]; [WebAttachments:86]RelatedID:2=[Customers:3]CustomerID:1; *)
			QUERY SELECTION:C341([WebAttachments:86];  & ; [WebAttachments:86]RelatedTableNum:11=Table:C252(->[Customers:3]))
			
		Else 
			REDUCE SELECTION:C351([WebAttachments:86]; 0)
		End if 
		
	Else 
		REDUCE SELECTION:C351([WebAttachments:86]; 0)
End case 