//%attributes = {}
checkInit
checkAddErrorIf(Not:C34(isUserAuthorizedToView(->[Customers:3])); "You are not allowed to view customers.")
checkAddErrorIf(Not:C34(isUserAuthorizedToView(->[eWires:13])); "You are not allowed to view eWires.")
checkAddErrorIf(Not:C34(isUserAuthorizedToView(->[Registers:10])); "You are not allowed to view Registers.")
checkAddErrorIf(Not:C34(isUserAuthorizedToView(->[Links:17])); "You are not allowed to view links.")
checkAddErrorIf(Not:C34(isUserAuthorizedToView(->[Invoices:5])); "You are not allowed to view invoices.")


If (isValidationConfirmed)
	handleProcess(->[CompanyInfo:7]; "browseTables_")
End if 