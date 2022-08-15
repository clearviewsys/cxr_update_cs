

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		//<>TODO convert to listbox based
		If ([Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)  //all good
		Else 
			RELATE ONE:C42([Invoices:5]CustomerID:2)  // load the customer record if it's not already loaded. 
		End if 
		
		setNextCustomer([Customers:3]CustomerID:1)  //set the global
		DEFAULT TABLE:C46([Invoices:5])
		
		PUSH RECORD:C176([Invoices:5])
		newRecordLinkedDocs
		POP RECORD:C177([Invoices:5])
		
		QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252(->[Invoices:5]); *)
		QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=[Invoices:5]InvoiceID:1)
		
	Else 
		
End case 