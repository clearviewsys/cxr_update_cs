//%attributes = {}
// modifyRecordCustomerByID (customerID)

C_TEXT:C284($1; $customerID)
$customerID:=$1

If (isUserAuthorizedToModify(->[Customers:3]))
	READ ONLY:C145([Customers:3])
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID)  // reload the record in case some information was changed
	If (Records in selection:C76([Customers:3])=1)
		modifyRecordTable(->[Customers:3])
	End if 
	READ ONLY:C145([Customers:3])  // added by TB Oct 2018 ; record was being locked even when invoice was cancelled
Else 
	myAlert("Sorry, you are not authorized to edit customer's profiles.")
End if 
