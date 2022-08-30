
If (Form event code:C388=On Load:K2:1)
	//SET FIELD RELATION([KYC_ReviewLog]CustomerID;Automatic;Manual)
	RELATE ONE:C42([KYC_ReviewLog:124]CustomerID:2)
End if 

If (Form event code:C388=On Unload:K2:2)
	//SET FIELD RELATION([KYC_ReviewLog]CustomerID;Manual;Manual)
End if 
If (Form event code:C388=On Outside Call:K2:11)
	RELATE ONE:C42([KYC_ReviewLog:124]CustomerID:2)
End if 

handleViewFormMethod