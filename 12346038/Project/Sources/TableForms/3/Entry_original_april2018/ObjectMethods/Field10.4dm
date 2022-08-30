If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	
	checkAddErrorIf(Not:C34(isUserComplianceOfficer); "This setting must be changed by a compliance officer only")
	
	
	If (isValidationConfirmed)
		If ([Customers:3]AML_IgnoreRepeatTransWarn:108)
			
			myAlert("NOTICE: Repeat transactions WILL NOT BE TRACKED for this customer anymore!")
		Else 
			myAlert("Repeat transactions will be tracked and warnings will be issued to the customer. ")
		End if 
	Else 
		[Customers:3]AML_IgnoreRepeatTransWarn:108:=Old:C35([Customers:3]AML_IgnoreRepeatTransWarn:108)
		
	End if 
	
End if 