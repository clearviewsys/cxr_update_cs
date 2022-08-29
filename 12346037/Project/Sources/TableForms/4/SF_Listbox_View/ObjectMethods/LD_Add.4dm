C_POINTER:C301($ptrTable; $ptrField)

$ptrTable:=Current default table:C363

If (Is nil pointer:C315($ptrTable))
	$ptrTable:=->[Invoices:5]
	DEFAULT TABLE:C46($ptrTable->)
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		//<>TODO convert to listbox based
		If ([Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)  //all good
		Else 
			RELATE ONE:C42([Invoices:5]CustomerID:2)  // load the customer record if it's not already loaded. 
		End if 
		
		setNextCustomer([Customers:3]CustomerID:1)  //set the global var
		//need this for the on load method of [LinkedDocs] to get related info
		
		//PUSH RECORD([Invoices])
		newRecordLinkedDocs
		//POP RECORD([Invoices])
		
		If (OK=1)
			$ptrField:=getPrimaryKeyFieldPtr($ptrTable; True:C214)
			QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252($ptrTable); *)
			QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=$ptrField->)
		End if 
		
	Else 
		
End case 