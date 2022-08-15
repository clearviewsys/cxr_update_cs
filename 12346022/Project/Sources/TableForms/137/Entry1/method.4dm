HandleEntryFormMethod(Current form table:C627; ->[AML_Alerts:137]userID:6; ->[AML_Alerts:137]userID:6; ->[AML_Alerts:137]branchID:10)

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Customers:3])
	selectNone(->[Customers:3])
	
	If ((Is new record:C668([AML_Alerts:137])) & (Records in selection:C76([AML_Alerts:137])=0))
		//[AML_Claims]ClaimDate:=Current date
		//[AML_Claims]DueDate:=Current date
		//[AML_Claims]AssignedToUserID:=getApplicationUser 
	End if 
End if 