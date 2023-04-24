handleViewFormMethod(Current form table:C627)

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Invoices:5])
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	handleAMLAlertStamp
	setVisibleIff([AML_Alerts:137]status:8#1; "b_resolve")
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[AML_Alerts:137]customerID:12)
End if 