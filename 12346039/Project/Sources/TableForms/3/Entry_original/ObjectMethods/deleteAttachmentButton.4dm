If (Records in selection:C76([LinkedDocs:4])>0)
	CONFIRM:C162("Are you sure you want to Delete the Picture ID?")
	If (OK=1)
		READ WRITE:C146([LinkedDocs:4])
		DELETE RECORD:C58([LinkedDocs:4])
		READ ONLY:C145([LinkedDocs:4])
		
		QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]CustomerID:1=[Customers:3]CustomerID:1)
		ORDER BY:C49([LinkedDocs:4]; [LinkedDocs:4]ExpiryDate:4)
	End if 
Else 
	myAlert("No records selected for deletion.")
End if 