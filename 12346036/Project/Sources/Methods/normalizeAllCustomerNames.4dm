//%attributes = {"shared":true}
// fixes the capitalization and extra spaces in names


If (isUserAdministrator)
	updateTableUsingMethod(->[Customers:3]; "NormalizeCustomerName"; True:C214)
Else 
	myAlert_AdminPrivilegeNeeded
End if 