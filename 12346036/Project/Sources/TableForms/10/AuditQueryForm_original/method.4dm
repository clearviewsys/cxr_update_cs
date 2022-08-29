declareAuditFormVariables

updatevRecNum

If (Form event code:C388=On Load:K2:1)
	
	If (vCustomerID="")  // we don't want a name appear when there is no customerID in the field
		UNLOAD RECORD:C212([Customers:3])
	End if 
	If (vAccountID="")
		UNLOAD RECORD:C212([Accounts:9])
	End if 
	
	WA OPEN URL:C1020(*; "WPTWebArea"; getFilePathByID("WebPivotTable URL"))
	
	
End if 



If (cbExcludeCompanies=1)
	cbExcludeMSBs:=1
	cbExcludeBanks:=1
End if 
