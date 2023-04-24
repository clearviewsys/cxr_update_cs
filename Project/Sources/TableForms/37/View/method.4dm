
If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	RELATE ONE:C42([AccountInOuts:37]CustomerID:2)  // load the customer ID
End if 

handleViewFormMethod(Current form table:C627)
