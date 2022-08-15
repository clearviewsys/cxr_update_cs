handleViewFormMethod

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	//[Customers]FullName
	Form:C1466.customerFullName:=getCustomerFullNameORDA([Relations:154]customerID:3)
	Form:C1466.toCustomerFullName:=getCustomerFullNameORDA([Relations:154]toCustomerID:4)
	
End if 