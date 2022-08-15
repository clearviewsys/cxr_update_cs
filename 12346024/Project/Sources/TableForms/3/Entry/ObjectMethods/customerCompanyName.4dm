
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		// this is buggy @tiran
		Self:C308->:=toTitleCase(Self:C308)
		//pickCompanyCustomer (OBJECT Get pointer(Object current);->[Customers]CompanyID;->[Customers]CompanyName)
		//sl_handleCompanyNameCompliance(False)
		sl_handleCustomerScreening(sl_CustomerCompany+sl_ForInputBox)
End case 
