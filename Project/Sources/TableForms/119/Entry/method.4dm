HandleEntryFormMethod(Current form table:C627; ->[AML_Reports:119]DiscoveredByUserID:4; ->[AML_Reports:119]DiscoveredByUserID:4; ->[AML_Reports:119]BranchID:15)

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Invoices:5])
	selectNone(->[Customers:3])
	selectNone(->[Invoices:5])
	ARRAY TEXT:C222(arrInvoices; 0)
	arrInvoices{0}:=""
	
	If (Is new record:C668([AML_Reports:119]))
		[AML_Reports:119]DiscoveryDate:3:=Current date:C33
		[AML_Reports:119]DiscoveredByUserID:4:=getApplicationUser
		[AML_Reports:119]isSuspiciousActivity:21:=True:C214
	End if 
	//setVisibleIff(isUserComplianceOfficer;"tab") // the tab won't show to normal users
End if 