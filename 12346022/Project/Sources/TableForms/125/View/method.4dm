handleViewFormMethod
If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Customers:3])
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	RELATE ONE:C42([AML_ReviewLog:125]CustomerID:2)  // load the customer
End if 
