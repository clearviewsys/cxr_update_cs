//%attributes = {}
C_TEXT:C284(webFirstName; webLastName; webCustomerName; webCity; webUnconfirmedCustomerName)


checkInit
checkIfNullString(->webFirstName; "First Name")  // for mandatory strings
checkIfNullString(->webLastName; "Last Name")  // for mandatory strings
checkIfNullString(->webUnconfirmedCustomerName; "Unconfirmed Customer Name")  // for mandatory strings
checkIfNullString(->webCity; "City")

If (webCustomerID#"")
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=webCustomerID)
	If (Records in selection:C76([Customers:3])#1)
		checkAddError("Customer ID is not valid; if you are not sure about this field, leave it blank.")
	Else 
		webCustomerName:=[Customers:3]FullName:40
	End if 
End if 
