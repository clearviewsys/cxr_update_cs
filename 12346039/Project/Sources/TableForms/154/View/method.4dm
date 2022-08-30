handleViewFormMethod

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	//[Customers]FullName
	
	READ ONLY:C145([RelationTypes:156])
	QUERY:C277([RelationTypes:156]; [RelationTypes:156]relationTypeID:1=[Relations:154]relationType:1)
	Form:C1466.relationType:=[RelationTypes:156]Description:2
	Form:C1466.customerFullName:=getCustomerFullNameORDA([Relations:154]customerID:3)
	Form:C1466.toCustomerFullName:=getCustomerFullNameORDA([Relations:154]toCustomerID:4)
	
End if 