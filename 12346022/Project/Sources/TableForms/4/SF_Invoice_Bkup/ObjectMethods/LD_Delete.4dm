Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		//<>TODO convert to listbox based
		If (Records in selection:C76([LinkedDocs:4])>0)
			GOTO SELECTED RECORD:C245([LinkedDocs:4]; Selected record number:C246([LinkedDocs:4]))
			
			CONFIRM:C162("Are you sure you want to Delete the Document: "+[LinkedDocs:4]DocReference:6+"?")
			If (OK=1)
				READ WRITE:C146([LinkedDocs:4])
				DELETE RECORD:C58([LinkedDocs:4])
				READ ONLY:C145([LinkedDocs:4])
				
				QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252(->[Invoices:5]); *)
				QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=[Invoices:5]InvoiceID:1)
				
				
			End if 
		Else 
			myAlert("No records selected for deletion.")
		End if 
		
	Else 
		
End case 