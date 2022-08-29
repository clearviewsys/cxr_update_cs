

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Table:C252(->[Customers:3])=[WebUsers:14]relatedTable:8)
			QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[WebUsers:14]recordID:9)
			
			If (Records in selection:C76([Customers:3])=1)
				editRecordTable(->[Customers:3])
			Else 
				myAlert("Not available.")
			End if 
		Else 
			myAlert("Not available.")
		End if 
		
	Else 
		
End case 