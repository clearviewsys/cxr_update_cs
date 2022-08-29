//%attributes = {}
C_BOOLEAN:C305(<>doCheckCustomerProfile)

If (<>doCheckCustomerProfile)  // FINTRAC compliancy checks
	checkAddWarningOnTrue(([Customers:3]Address:7=""); "The company's address is missing.")
	checkAddWarningOnTrue(([Customers:3]CountryCode:113=""); "Country Code is Missing")
	//checkAddWarningOnTrue (([Customers]FirstName+[Customers]LastName="");"There company's main Contact Person is missing.")
End if 